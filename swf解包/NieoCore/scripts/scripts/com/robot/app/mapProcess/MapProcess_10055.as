package com.robot.app.mapProcess
{
   import com.robot.app.fightLevel.FightPetBagController;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.CommandID;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.config.xml.PetXMLInfo;
   import com.robot.core.dispatcher.FightDispatcher;
   import com.robot.core.event.PetFightEvent;
   import com.robot.core.info.fightInfo.PetFightModel;
   import com.robot.core.info.fightInfo.attack.FightOverInfo;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.PetManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.ui.alert.Alarm;
   import com.robot.core.ui.alert.Alert;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.ByteArray;
   import gs.TweenLite;
   import org.taomee.events.SocketEvent;
   import org.taomee.manager.ResourceManager;
   import org.taomee.manager.ToolTipManager;
   
   public class MapProcess_10055 extends BaseMapProcess
   {
      
      private static var _pro:int = 0;
      
      private static var _energy:int = 7;
      
      private static var _door:Array = [0,0,0,0,0,0,0,0];
      
      private var _petMc:MovieClip;
      
      private var _index:int;
      
      private var _pet:Array = [210,570,860,693,99,765,465,563];
      
      private var _petPos:Array = [new Point(265,123),new Point(197,177),new Point(190,247),new Point(216,314),new Point(695,123),new Point(763,175),new Point(770,244),new Point(744,310)];
      
      public function MapProcess_10055()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86063749);
         this.hideTopItem();
         this.updateEnergy();
         PetFightModel.mode = PetFightModel.MULTI_MODE;
         PetFightModel.type = PetFightModel.FIGHT_DEMON_SPACE;
         ToolBarController.panel.hide();
         LevelManager.iconLevel.visible = false;
         ToolTipManager.add(conLevel["bar"],"血之能量");
         ToolTipManager.add(topLevel["bag"],"精灵背包");
         topLevel["bag"].addEventListener(MouseEvent.CLICK,this.onBagClick);
         ToolTipManager.add(topLevel["exit"],"空间裂缝");
         topLevel["exit"].addEventListener(MouseEvent.CLICK,this.onExitClick);
         if(_pro == 0)
         {
            this.startPro_0();
         }
         FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,this.onFightComplete);
         SocketConnection.addCmdListener(CommandID.EXIT_GHOST_SPACE,this.onExitGhostSpace);
      }
      
      private function startPro_0() : void
      {
         AnimateManager.playFullScreenAnimate(ClientConfig.getFullMovie("DemonSpaceSwf_1"),function():void
         {
            MainManager.actorModel.pos = new Point(480,120);
            TweenLite.to(MainManager.actorModel,0.5,{
               "x":480,
               "y":460,
               "onComplete":function():void
               {
                  AnimateManager.playMcAnimate(conLevel["boss"],1,"mc_1",function():void
                  {
                     _pro = 1;
                     startPro_1();
                  });
               }
            });
         });
      }
      
      private function startPro_1() : void
      {
         if(this.getIsClear(_door))
         {
            SocketConnection.addCmdListener(CommandID.ENTER_NEXT_STAGE,function(param1:SocketEvent):void
            {
               SocketConnection.removeCmdListener(CommandID.ENTER_NEXT_STAGE,arguments.callee);
               _pro = 2;
               startPro_2();
            });
            SocketConnection.send(CommandID.ENTER_NEXT_STAGE);
         }
         else
         {
            topLevel["bg"].visible = true;
            topLevel["icon_1"].visible = true;
            topLevel["icon_2"].visible = true;
            AnimateManager.playMcAnimate(topLevel["icon_1"],1,"mc_1",function():void
            {
               ToolTipManager.add(topLevel["icon_1"],"正面");
               topLevel["icon_1"].buttonMode = true;
               topLevel["icon_1"].addEventListener(MouseEvent.CLICK,onIconClick);
               ToolTipManager.add(topLevel["icon_2"],"反面");
               topLevel["icon_2"].buttonMode = true;
               topLevel["icon_2"].addEventListener(MouseEvent.CLICK,onIconClick);
            });
            AnimateManager.playMcAnimate(topLevel["icon_2"],1,"mc_1");
         }
      }
      
      private function onIconClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         var icon:MovieClip = e.currentTarget as MovieClip;
         if(icon == topLevel["icon_1"])
         {
            AnimateManager.playMcAnimate(topLevel["icon_1"],2,"mc_2",function():void
            {
               hideTopItem();
               getIconResult(topLevel["result_1"]);
            });
            AnimateManager.playMcAnimate(topLevel["icon_2"],3,"mc_3");
         }
         else if(icon == topLevel["icon_2"])
         {
            AnimateManager.playMcAnimate(topLevel["icon_2"],2,"mc_2",function():void
            {
               hideTopItem();
               getIconResult(topLevel["result_2"]);
            });
            AnimateManager.playMcAnimate(topLevel["icon_1"],3,"mc_3");
         }
      }
      
      private function getIconResult(param1:MovieClip) : void
      {
         var mc:MovieClip = param1;
         SocketConnection.addCmdListener(CommandID.FALLING_ICON_GHOST_SPACE,function(param1:SocketEvent):void
         {
            var by:ByteArray;
            var i:uint = 0;
            var e:SocketEvent = param1;
            SocketConnection.removeCmdListener(CommandID.FALLING_ICON_GHOST_SPACE,arguments.callee);
            by = e.data as ByteArray;
            i = by.readUnsignedInt();
            mc.visible = true;
            AnimateManager.playMcAnimate(mc,1,"mc_1",function():void
            {
               if(i == 0)
               {
                  _energy = _energy - 1;
                  updateEnergy();
                  AnimateManager.playMcAnimate(mc,2,"mc_2",function():void
                  {
                     hideTopItem();
                     AnimateManager.playMcAnimate(conLevel["boss"],2,"mc_2",function():void
                     {
                        loadPetResouce();
                     });
                  });
               }
               else if(i == 1)
               {
                  _energy += 1;
                  updateEnergy();
                  AnimateManager.playMcAnimate(mc,3,"mc_3",function():void
                  {
                     hideTopItem();
                     loadPetResouce();
                  });
               }
            });
         });
         SocketConnection.send(CommandID.FALLING_ICON_GHOST_SPACE);
      }
      
      private function loadPetResouce() : void
      {
         this._index = this.getRandomDoor(_door);
         AnimateManager.playMcAnimate(conLevel["boss"],3,"mc_3",function():void
         {
            conLevel["small"].x = _petPos[_index].x;
            conLevel["small"].y = _petPos[_index].y;
            AnimateManager.playMcAnimate(conLevel["small"],0,"",function():void
            {
               ResourceManager.getResource(ClientConfig.getPetSwfPath(_pet[_index]),function(param1:DisplayObject):void
               {
                  _petMc = param1 as MovieClip;
                  _petMc.x = _petPos[_index].x;
                  _petMc.y = _petPos[_index].y;
                  _petMc.buttonMode = true;
                  _petMc.addEventListener(MouseEvent.CLICK,onFishClick);
                  ToolTipManager.add(_petMc,PetXMLInfo.getName(_pet[_index]));
                  conLevel.addChild(_petMc);
               },"pet");
            });
         });
      }
      
      private function startPro_2() : void
      {
         AnimateManager.playMcAnimate(conLevel["boss"],4,"mc_4",function():void
         {
            ToolTipManager.add(conLevel["boss"],"泰沃斯");
            conLevel["boss"].buttonMode = true;
            conLevel["boss"].addEventListener(MouseEvent.CLICK,onBossClick);
         });
      }
      
      private function continuePro_2() : void
      {
         AnimateManager.playMcAnimate(conLevel["boss"],5,"mc_5",function():void
         {
            if(PetManager.containsBagForID(890))
            {
               ModuleManager.showModule(ClientConfig.getAppModule("GhostSpaceAdvanceSkill"),"正在打开...",890);
            }
            else
            {
               SocketConnection.send(CommandID.EXIT_GHOST_SPACE);
            }
         });
      }
      
      private function onFishClick(param1:MouseEvent) : void
      {
         SocketConnection.send(CommandID.CHALLENGE_GHOST,this._index + 1);
      }
      
      private function onBossClick(param1:MouseEvent) : void
      {
         SocketConnection.send(CommandID.CHALLENGE_GHOST,1);
      }
      
      private function hideTopItem() : void
      {
         topLevel["bg"].visible = false;
         topLevel["icon_1"].visible = false;
         topLevel["icon_2"].visible = false;
         topLevel["result_1"].visible = false;
         topLevel["result_2"].visible = false;
      }
      
      private function updateEnergy() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 16)
         {
            if(_loc1_ <= _energy)
            {
               conLevel["bar"]["bar_" + _loc1_].gotoAndStop(1);
            }
            else
            {
               conLevel["bar"]["bar_" + _loc1_].gotoAndStop(2);
            }
            _loc1_++;
         }
      }
      
      private function onBagClick(param1:MouseEvent) : void
      {
         FightPetBagController.show();
      }
      
      private function onExitClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         Alert.show("再次进入时需要重新挑战，确定要离开伏魔空间吗？",function():void
         {
            SocketConnection.send(CommandID.EXIT_GHOST_SPACE);
         });
      }
      
      private function onExitGhostSpace(param1:SocketEvent) : void
      {
         _pro = 0;
         _energy = 7;
         _door = [0,0,0,0,0,0,0,0];
         PetFightModel.type = 0;
         MapManager.changeMap(14);
      }
      
      private function onFightComplete(param1:PetFightEvent) : void
      {
         var e:PetFightEvent = param1;
         var info:FightOverInfo = e.dataObj as FightOverInfo;
         if(info.winnerID == MainManager.actorID)
         {
            if(_pro == 1)
            {
               this.startPro_1();
            }
            else if(_pro == 2)
            {
               this.continuePro_2();
            }
         }
         else
         {
            Alarm.show("非常可惜，你被打败了！",function():void
            {
               SocketConnection.send(CommandID.EXIT_GHOST_SPACE);
            });
         }
      }
      
      private function getRandomDoor(param1:Array) : int
      {
         var _loc2_:int = 0;
         do
         {
            _loc2_ = int(Math.random() * param1.length);
         }
         while(param1[_loc2_] != 0);
         
         param1[_loc2_] = 1;
         return _loc2_;
      }
      
      private function getIsClear(param1:Array) : Boolean
      {
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            if(param1[_loc2_] == 0)
            {
               return false;
            }
            _loc2_++;
         }
         return true;
      }
      
      override public function destroy() : void
      {
         ToolBarController.panel.show();
         LevelManager.iconLevel.visible = true;
         ToolTipManager.remove(topLevel["bar"]);
         ToolTipManager.remove(topLevel["bag"]);
         topLevel["bag"].removeEventListener(MouseEvent.CLICK,this.onBagClick);
         ToolTipManager.remove(topLevel["exit"]);
         topLevel["exit"].removeEventListener(MouseEvent.CLICK,this.onExitClick);
         FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,this.onFightComplete);
         SocketConnection.removeCmdListener(CommandID.EXIT_GHOST_SPACE,this.onExitGhostSpace);
         ToolTipManager.remove(topLevel["icon_1"]);
         ToolTipManager.remove(topLevel["icon_2"]);
         topLevel["icon_1"].removeEventListener(MouseEvent.CLICK,this.onIconClick);
         topLevel["icon_2"].removeEventListener(MouseEvent.CLICK,this.onIconClick);
         if(this._petMc)
         {
            ToolTipManager.remove(this._petMc);
            this._petMc.removeEventListener(MouseEvent.CLICK,this.onFishClick);
         }
         ToolTipManager.remove(conLevel["boss"]);
         conLevel["boss"].removeEventListener(MouseEvent.CLICK,this.onBossClick);
      }
   }
}

