package com.robot.app.mapProcess
{
   import com.robot.app.fightLevel.FightPetBagController;
   import com.robot.app.mapProcess.control.HonorsHallController;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.CommandID;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.config.xml.PetXMLInfo;
   import com.robot.core.dispatcher.FightDispatcher;
   import com.robot.core.event.MapEvent;
   import com.robot.core.event.PetFightEvent;
   import com.robot.core.event.RobotEvent;
   import com.robot.core.info.fightInfo.PetFightModel;
   import com.robot.core.info.fightInfo.attack.FightOverInfo;
   import com.robot.core.manager.BufferRecordManager;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.NonoManager;
   import com.robot.core.manager.map.MapTransEffect;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.ui.alert.Alarm;
   import com.robot.core.ui.alert.Alert;
   import com.robot.core.ui.alert.SpecialAlert;
   import com.robot.core.utils.TextFormatUtil;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   import org.taomee.component.control.MLoadPane;
   import org.taomee.debug.DebugTrace;
   import org.taomee.events.SocketEvent;
   import org.taomee.manager.EventManager;
   import org.taomee.manager.ResourceManager;
   import org.taomee.manager.ToolTipManager;
   import org.taomee.utils.DisplayUtil;
   
   public class MapProcess_10035 extends BaseMapProcess
   {
      
      public static var isBlack:uint;
      
      public static var monID:uint;
      
      public static var isFirstEnter:Boolean;
      
      public static var petID:uint;
      
      private static var _isBlack:uint;
      
      private static var _currentBoss:MovieClip;
      
      private static var _isSameMap:Boolean;
      
      private static var _currentBossLevelObj:Object;
      
      private static var _isWin:Boolean = false;
      
      private static var _level:uint = 0;
      
      private static var _isFightBoss:Boolean = false;
      
      private var isPlayMovie:Boolean = false;
      
      private var bossLevelArr:Array = [{
         "level":29,
         "effectmc":"boss_level_29",
         "bossmc":"boss_mc_29",
         "bossesmc":"boss_escape_29",
         "first":0,
         "movieid":13,
         "movie":"startintrol"
      },{
         "level":59,
         "effectmc":"boss_level_59",
         "bossmc":"boss_mc_59",
         "bossesmc":"boss_escape_59",
         "first":30,
         "movieid":22,
         "movie":"secondintrol"
      },{
         "level":79,
         "effectmc":"boss_level_79",
         "bossmc":"boss_mc_79",
         "bossesmc":"boss_escape_79",
         "first":60,
         "movieid":0,
         "movie":""
      }];
      
      public function MapProcess_10035()
      {
         super();
      }
      
      public static function set level(param1:uint) : void
      {
         _level = param1;
      }
      
      private function initMap() : void
      {
         if(!_isSameMap)
         {
            MapManager.currentMap.topLevel["recordMC"].visible = false;
            SocketConnection.addCmdListener(CommandID.FIGHTLADDER_GET_PET_BESTRECORD,this.onRecordGot);
            SocketConnection.send(CommandID.FIGHTLADDER_GET_PET_BESTRECORD,petID);
            _isSameMap = true;
            topLevel["seer_show_effect"].gotoAndPlay(2);
            LevelManager.iconLevel.visible = false;
            ToolBarController.panel.hide();
            _isFightBoss = false;
            _isWin = false;
            conLevel["door_0"].visible = false;
            conLevel["door_0"].buttonMode = true;
            _isBlack = isBlack;
            this.initMapEffect();
         }
         else
         {
            conLevel["door_0"].visible = true;
            animatorLevel["floor_0"].gotoAndPlay(animatorLevel["floor_0"].totalFrames);
            switch(_isBlack)
            {
               case 0:
                  AnimateManager.playMcAnimate(animatorLevel["floor_1"],1,"mc",function():void
                  {
                  },true);
                  break;
               case 1:
                  AnimateManager.playMcAnimate(animatorLevel["floor_1"],2,"mc",function():void
                  {
                  },true);
                  AnimateManager.playMcAnimate(animatorLevel["floor_2"],2,"mc",function():void
                  {
                  },true);
                  break;
               case 2:
                  AnimateManager.playMcAnimate(animatorLevel["floor_1"],3,"mc",function():void
                  {
                  },true);
            }
         }
      }
      
      private function onRecordGot(param1:SocketEvent) : void
      {
         var dataArr:ByteArray;
         var exist:uint;
         var creatorNick:String;
         var bestLevel:uint;
         var recordTime:uint;
         var recordDate:Date = null;
         var e:SocketEvent = param1;
         SocketConnection.removeCmdListener(CommandID.FIGHTLADDER_GET_PET_BESTRECORD,this.onRecordGot);
         dataArr = e.data as ByteArray;
         exist = dataArr.readUnsignedInt();
         creatorNick = dataArr.readUTFBytes(16);
         bestLevel = dataArr.readUnsignedInt();
         recordTime = dataArr.readUnsignedInt();
         if(exist)
         {
            MapManager.currentMap.topLevel["recordMC"]["petName"].text = PetXMLInfo.getName(petID);
            MapManager.currentMap.topLevel["recordMC"]["creator"].text = creatorNick;
            MapManager.currentMap.topLevel["recordMC"]["bestLv"].text = bestLevel.toString() + "层";
            recordDate = new Date();
            recordDate.setTime(recordTime * 1000);
            MapManager.currentMap.topLevel["recordMC"]["time"].text = recordDate.fullYear.toString() + "年" + (recordDate.month + 1).toString() + "月" + recordDate.date.toString() + "日";
            ResourceManager.getResource(ClientConfig.getPetHeadPath(petID),function(param1:DisplayObject):void
            {
               DisplayUtil.removeAllChild(MapManager.currentMap.topLevel["recordMC"]["pet"]);
               MapManager.currentMap.topLevel["recordMC"]["pet"].addChild(param1);
               param1.scaleX = param1.scaleY = 0.7;
               (param1 as MovieClip).cacheAsBitmap = true;
               MapManager.currentMap.topLevel["recordMC"].visible = true;
            });
         }
         else
         {
            MapManager.currentMap.topLevel["recordMC"].visible = false;
         }
      }
      
      private function onNoPet(param1:Event) : void
      {
         EventManager.removeEventListener(RobotEvent.NO_PET_CAN_FIGHT,this.onNoPet);
         SocketConnection.removeCmdListener(CommandID.START_LADDER_FIGHT,this.onSuccessHandler);
         if(_currentBoss)
         {
            _currentBoss.buttonMode = true;
            _currentBoss.addEventListener(MouseEvent.CLICK,this.onFightBtnClickHandler);
         }
      }
      
      private function noAwardHandler(param1:RobotEvent) : void
      {
         var e:RobotEvent = param1;
         Alarm.show("恭喜你！你已经通关了！",function():void
         {
            conLevel[_currentBossLevelObj.effectmc].visible = true;
            AnimateManager.playMcAnimate(conLevel[_currentBossLevelObj.effectmc],0,"",function():void
            {
               leaveFight();
            });
         });
      }
      
      override protected function init() : void
      {
         var i:uint;
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         topLevel["level_con"]["level_mc"].visible = false;
         ToolTipManager.add(conLevel["level_map_mc"],"太空站");
         ToolTipManager.add(conLevel["mosterMc"],"精灵背包");
         conLevel["mosterMc"].addEventListener(MouseEvent.CLICK,this.onMonsterHandler);
         EventManager.addEventListener(RobotEvent.NO_PET_CAN_FIGHT,this.onNoPet);
         EventManager.addEventListener("11040",this.noAwardHandler);
         FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,this.petFightOver);
         i = 0;
         while(i < this.bossLevelArr.length)
         {
            DebugTrace.show(this.bossLevelArr[i].bossmc);
            conLevel[this.bossLevelArr[i].bossmc].visible = false;
            conLevel[this.bossLevelArr[i].bossesmc].visible = false;
            if(this.bossLevelArr[i].first == _level && i != 2)
            {
               if(!BufferRecordManager.getState(MainManager.actorInfo,this.bossLevelArr[i].movieid))
               {
                  BufferRecordManager.setState(MainManager.actorInfo,this.bossLevelArr[i].movieid,true);
                  AnimateManager.playFullScreenAnimate(ClientConfig.getFullMovie(this.bossLevelArr[i].movie),function():void
                  {
                     isPlayMovie = true;
                     initMap();
                  });
               }
            }
            i++;
         }
         if(!this.isPlayMovie)
         {
            this.initMap();
         }
         if(MainManager.actorModel.pet)
         {
            MainManager.actorModel.pet.visible = false;
         }
         MainManager.actorModel.hideNono();
         conLevel["level_map_mc"].addEventListener(MouseEvent.CLICK,this.onLevelMapHandler);
         SocketConnection.addCmdListener(CommandID.NEXT_LEVEL,this.onNextLevelHandler);
      }
      
      override public function destroy() : void
      {
         if(_currentBoss)
         {
            ToolTipManager.remove(_currentBoss);
         }
         ResourceManager.stop();
         EventManager.removeEventListener(RobotEvent.NO_PET_CAN_FIGHT,this.onNoPet);
         SocketConnection.removeCmdListener(CommandID.START_LADDER_FIGHT,this.onSuccessHandler);
         EventManager.removeEventListener("11040",this.noAwardHandler);
         FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,this.petFightOver);
         ToolTipManager.remove(conLevel["level_map_mc"]);
         ToolTipManager.remove(conLevel["mosterMc"]);
         conLevel["mosterMc"].removeEventListener(MouseEvent.CLICK,this.onMonsterHandler);
         conLevel["level_map_mc"].removeEventListener(MouseEvent.CLICK,this.onLevelMapHandler);
         if(MainManager.actorModel.pet)
         {
            MainManager.actorModel.pet.visible = true;
         }
         MainManager.actorModel.showNono(NonoManager.info,MainManager.actorInfo.actionType);
         SocketConnection.removeCmdListener(CommandID.NEXT_LEVEL,this.onNextLevelHandler);
      }
      
      private function onLevelMapHandler(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         Alert.show("确定要离开战斗阶梯吗？",function():void
         {
            leaveFight();
         });
      }
      
      private function onMonsterHandler(param1:MouseEvent) : void
      {
         FightPetBagController.show(true);
      }
      
      private function initMapEffect() : void
      {
         var len:uint = 0;
         var i:uint = 0;
         topLevel["seer_show_effect"].gotoAndStop(1);
         topLevel["seer_show_effect"].gotoAndPlay(2);
         switch(_isBlack)
         {
            case 0:
               topLevel["level_con"]["level_mc"].visible = true;
               topLevel["level_con"]["level_mc"].gotoAndStop(_level + 1);
               AnimateManager.playMcAnimate(topLevel["level_con"]["level_effect"],0,"",function():void
               {
                  topLevel["level_con"]["level_mc"].visible = false;
                  animatorLevel["floor_0"].gotoAndPlay(2);
                  AnimateManager.playMcAnimate(animatorLevel["floor_1"],1,"mc",function():void
                  {
                     loadBoss(monID);
                  });
               });
               break;
            case 1:
               AnimateManager.playMcAnimate(topLevel["black_show_effect"],0,"",function():void
               {
                  animatorLevel["floor_0"].gotoAndPlay(2);
                  AnimateManager.playMcAnimate(animatorLevel["floor_2"],0,"",function():void
                  {
                     AnimateManager.playMcAnimate(animatorLevel["floor_1"],2,"mc",function():void
                     {
                        loadBoss(monID);
                     });
                  });
               });
               break;
            case 2:
               len = this.bossLevelArr.length;
               if(this.bossLevelArr[len - 1].level == _level)
               {
                  _isFightBoss = true;
               }
               i = 0;
               while(i < len)
               {
                  if(this.bossLevelArr[i].level == _level)
                  {
                     _currentBossLevelObj = this.bossLevelArr[i];
                     break;
                  }
                  i++;
               }
               _currentBoss = conLevel[_currentBossLevelObj.bossmc];
               AnimateManager.playMcAnimate(topLevel[_currentBossLevelObj.effectmc],0,"",function():void
               {
                  animatorLevel["floor_0"].gotoAndPlay(2);
                  AnimateManager.playMcAnimate(animatorLevel["floor_1"],3,"mc",function():void
                  {
                     _currentBoss.visible = true;
                     AnimateManager.playMcAnimate(_currentBoss,0,"",function():void
                     {
                        _currentBoss.buttonMode = true;
                        _currentBoss.addEventListener(MouseEvent.CLICK,onFightBtnClickHandler);
                     });
                  });
               });
         }
      }
      
      private function loadBoss(param1:uint) : void
      {
         var _loc2_:String = ClientConfig.getPetSwfPath(param1);
         ResourceManager.getResource(_loc2_,this.loadComHandler,"pet");
      }
      
      private function loadComHandler(param1:DisplayObject) : void
      {
         var mc:MovieClip = null;
         var icon:MLoadPane = null;
         var dis:DisplayObject = param1;
         mc = dis as MovieClip;
         if(mc)
         {
            mc.gotoAndStop("leftdown");
            mc.addEventListener(Event.ENTER_FRAME,function():void
            {
               var _loc2_:MovieClip = mc.getChildAt(0) as MovieClip;
               if(_loc2_)
               {
                  _loc2_.gotoAndStop(1);
                  mc.removeEventListener(Event.ENTER_FRAME,arguments.callee);
               }
            });
            icon = new MLoadPane(mc);
            if(mc.width > mc.height)
            {
               icon.fitType = MLoadPane.FIT_WIDTH;
            }
            else
            {
               icon.fitType = MLoadPane.FIT_HEIGHT;
            }
            icon.setSizeWH(80,80);
            icon.content.x = 650;
            icon.content.y = 125;
            _currentBoss = icon.content as MovieClip;
            _currentBoss.buttonMode = true;
            _currentBoss.addEventListener(MouseEvent.CLICK,this.onFightBtnClickHandler);
            ToolTipManager.add(_currentBoss,PetXMLInfo.getName(monID));
            AnimateManager.playMcAnimate(topLevel["boss_show_effect"],0,"",function():void
            {
               depthLevel.addChild(_currentBoss);
            });
         }
      }
      
      private function onFightBtnClickHandler(param1:MouseEvent) : void
      {
         FightDispatcher.addEventListener(PetFightEvent.FIGHT_CLOSE,this.handle);
         PetFightModel.enemyName = PetXMLInfo.getName(monID);
         PetFightModel.mode = PetFightModel.MULTI_MODE;
         PetFightModel.status = PetFightModel.FIGHT_WITH_BOSS;
         SocketConnection.addCmdListener(CommandID.START_LADDER_FIGHT,this.onSuccessHandler);
         SocketConnection.send(CommandID.START_LADDER_FIGHT);
      }
      
      private function onSuccessHandler(param1:SocketEvent) : void
      {
         SocketConnection.removeCmdListener(CommandID.START_LADDER_FIGHT,this.onSuccessHandler);
      }
      
      private function handle(param1:PetFightEvent) : void
      {
         FightDispatcher.removeEventListener(PetFightEvent.FIGHT_CLOSE,this.handle);
         var _loc2_:FightOverInfo = param1.dataObj["data"];
         if(_loc2_.reason == 5)
         {
            _isWin = false;
         }
         if(_loc2_.winnerID == MainManager.actorInfo.userID)
         {
            _isWin = true;
            SocketConnection.addCmdListener(CommandID.FIGHTLADDER_GET_HAS_BREAKRECORD,this.onBreakRecordGot);
            SocketConnection.send(CommandID.FIGHTLADDER_GET_HAS_BREAKRECORD);
         }
         else
         {
            _isWin = false;
         }
      }
      
      private function onBreakRecordGot(param1:SocketEvent) : void
      {
         SocketConnection.removeCmdListener(CommandID.FIGHTLADDER_GET_HAS_BREAKRECORD,this.onBreakRecordGot);
         var _loc2_:ByteArray = param1.data as ByteArray;
         var _loc3_:uint = _loc2_.readUnsignedInt();
         var _loc4_:uint = _loc2_.readUnsignedInt();
         var _loc5_:uint = _loc2_.readUnsignedInt();
         var _loc6_:uint = _loc2_.readUnsignedInt();
         _loc2_.readUnsignedInt();
         _loc2_.readUTFBytes(16);
         var _loc7_:uint = _loc2_.readUnsignedInt();
         switch(_loc3_)
         {
            case 0:
               if(_loc6_ == _level && _loc6_ != 0)
               {
                  Alarm.show("很可惜你以微弱的回合劣势，未能刷新纪录！");
               }
               break;
            case 1:
            case 2:
               Alarm.show("恭喜你使用" + TextFormatUtil.getRedTxt(PetXMLInfo.getName(_loc5_)) + "刷新了到达" + TextFormatUtil.getRedTxt(_loc6_.toString()) + "层的新记录！");
         }
         if(_loc4_ != 0)
         {
            Alarm.show("恭喜你获得了" + _loc4_ + "赛尔豆");
            MainManager.actorInfo.coins += _loc4_;
         }
         SocketConnection.addCmdListener(CommandID.FIGHTLADDER_GET_PET_BESTRECORD,this.onRecordGot);
         SocketConnection.send(CommandID.FIGHTLADDER_GET_PET_BESTRECORD,petID);
      }
      
      private function onNextLevelHandler(param1:SocketEvent) : void
      {
         var _loc2_:ByteArray = param1.data as ByteArray;
         _level = _loc2_.readUnsignedInt();
         isBlack = _loc2_.readUnsignedInt();
         monID = _loc2_.readUnsignedInt();
         _isBlack = isBlack;
         this.goUPFloor();
      }
      
      public function nextLevel() : void
      {
         SocketConnection.send(CommandID.NEXT_LEVEL);
      }
      
      public function goUPFloor() : void
      {
         var mte:MapTransEffect = null;
         conLevel["door_0"].visible = false;
         FightPetBagController.destroy();
         switch(_isBlack)
         {
            case 0:
            case 2:
               MainManager.actorModel.visible = false;
               MainManager.actorModel.alpha = 0;
               mte = new MapTransEffect(MapManager.currentMap,1);
               mte.addEventListener(MapEvent.MAP_EFFECT_COMPLETE,function(param1:MapEvent):void
               {
                  DisplayUtil.removeAllChild(LevelManager.appLevel);
                  DisplayUtil.removeAllChild(LevelManager.mapLevel);
                  LevelManager.mapLevel.addChild(MapManager.currentMap.root);
                  MainManager.actorModel.visible = true;
                  MainManager.actorModel.x = 325;
                  MainManager.actorModel.y = 365;
                  MainManager.actorModel.alpha = 1;
                  animatorLevel["floor_0"].gotoAndStop(1);
                  animatorLevel["floor_1"].gotoAndStop(4);
                  initMapEffect();
               });
               mte.star();
               break;
            case 1:
               AnimateManager.playFullScreenAnimate(ClientConfig.getFullMovie("slowdown"),function():void
               {
                  initMapEffect();
                  MainManager.actorModel.x = 325;
                  MainManager.actorModel.y = 365;
               });
         }
      }
      
      private function petFightOver(param1:PetFightEvent) : void
      {
         var e:PetFightEvent = param1;
         if(_isWin)
         {
            if(Boolean(_currentBossLevelObj) && _currentBossLevelObj.level == 29)
            {
               BufferRecordManager.setState(MainManager.actorInfo,24,true);
            }
            if(_isFightBoss)
            {
               conLevel[_currentBossLevelObj.bossesmc].visible = true;
               AnimateManager.playMcAnimate(conLevel[_currentBossLevelObj.bossesmc],0,"",function():void
               {
                  SpecialAlert.show(1,"恭喜你通关战斗阶梯，我们推荐你前往黄金十二宫。",function():void
                  {
                     HonorsHallController.checkState();
                     HonorsHallController.openPanel(1);
                  },function():void
                  {
                     MapManager.changeMap(14);
                  });
               });
               if(_currentBoss)
               {
                  _currentBoss.visible = false;
               }
            }
            else
            {
               animatorLevel["door_mc"].gotoAndPlay(2);
            }
         }
         else
         {
            this.leaveFight();
         }
      }
      
      public function leaveFight() : void
      {
         SocketConnection.addCmdListener(CommandID.LEVEL_FIGHT_LADDER,this.onLeaveFightHandler);
         SocketConnection.send(CommandID.LEVEL_FIGHT_LADDER);
      }
      
      private function onLeaveFightHandler(param1:SocketEvent) : void
      {
         SocketConnection.removeCmdListener(CommandID.LEVEL_FIGHT_LADDER,this.onLeaveFightHandler);
         _isSameMap = false;
         MapManager.changeMap(405);
         if(_isWin == false)
         {
            LevelManager.iconLevel.addChild(Alarm.show("非常可惜，你失败了，下次请继续努力吧！"));
         }
         else
         {
            _isWin = false;
         }
         ToolBarController.panel.show();
         LevelManager.iconLevel.visible = true;
      }
   }
}

