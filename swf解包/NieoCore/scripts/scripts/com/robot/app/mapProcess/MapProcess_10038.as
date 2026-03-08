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
   import com.robot.core.info.fightInfo.PetFightModel;
   import com.robot.core.info.fightInfo.attack.FightOverInfo;
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
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import org.taomee.events.SocketEvent;
   import org.taomee.manager.ResourceManager;
   import org.taomee.manager.ToolTipManager;
   import org.taomee.utils.DisplayUtil;
   
   public class MapProcess_10038 extends BaseMapProcess
   {
      
      private static var _container:Array;
      
      private static var _temp:Array;
      
      public static var _stage:int;
      
      public static var _monCnt:int;
      
      public static var _monID:Array;
      
      private static var _oldStage:int;
      
      private static var _oldMonCnt:int;
      
      private static var _oldMonID:Array;
      
      public static var _type:int = 0;
      
      private static var _index:int = 0;
      
      private static var _isFight:Boolean = false;
      
      private static const _point:Array = [[2],[1,3],[1,2,3],[0,1,3,4],[0,1,2,3,4]];
      
      private static const _name:Array = ["冰系精灵训练师","机械系精灵训练师","飞行系精灵训练师","地面系精灵训练师","超能系精灵训练师","水系精灵训练师","火系精灵训练师","草系精灵训练师","战斗系精灵训练师","SPT先锋队基层部队队长","光系精灵训练师","火系精灵训练师","电系精灵训练师","地面系精灵训练师","超能系精灵训练师","暗影系精灵训练师","普通系精灵训练师","双属性精灵训练师","融合精灵训练师","光明卡修","训练师","训练师","训练师","训练师","训练师","训练师","训练师","训练师","训练师","训练师"];
      
      public function MapProcess_10038()
      {
         super();
      }
      
      override protected function init() : void
      {
         if(_type == 1)
         {
            MainManager.actorModel.hideNono();
         }
         ToolBarController.panel.hide();
         LevelManager.iconLevel.visible = false;
         PetFightModel.mode = PetFightModel.MULTI_MODE;
         PetFightModel.status = PetFightModel.FIGHT_WITH_BOSS;
         FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,this.onFightComplete);
         ToolTipManager.add(conLevel["bag_btn"],"精灵背包");
         ToolTipManager.add(conLevel["leave_btn"],"太空站");
         conLevel["bag_btn"].addEventListener(MouseEvent.CLICK,this.onBagClick);
         conLevel["leave_btn"].addEventListener(MouseEvent.CLICK,this.onLeaveClick);
         _container = [depthLevel["con_0"],depthLevel["con_1"],depthLevel["con_2"],depthLevel["con_3"],depthLevel["con_4"]];
         this.initMap();
      }
      
      private function initMap() : void
      {
         var i:int;
         var t:uint = 0;
         typeLevel["mc"].y = 216;
         MapManager.currentMap.makeMapArray();
         i = 0;
         while(i < 6)
         {
            depthLevel["light_" + i].visible = false;
            i++;
         }
         conLevel["door"].visible = false;
         conLevel["light"].gotoAndStop(1);
         conLevel["shin"].gotoAndStop(_type + 1);
         if(_isFight)
         {
            conLevel["num"].gotoAndStop(_stage + 1);
            conLevel["npc"].gotoAndStop(_stage + 1);
            ToolTipManager.add(conLevel["npc"],_name[_stage - 1]);
         }
         else
         {
            conLevel["leave_btn"].enabled = false;
            conLevel["leave_btn"].mouseEnabled = false;
            conLevel["num"].gotoAndStop(_stage + 2);
            conLevel["npc"].gotoAndStop(_stage + 2);
            ToolTipManager.add(conLevel["npc"],_name[_stage]);
            if(_type == 0)
            {
               conLevel["level"].gotoAndStop(_stage + 2);
            }
            else if(_type == 1)
            {
               conLevel["level_hero"].gotoAndStop(_stage + 2);
            }
            t = setTimeout(function():void
            {
               clearTimeout(t);
               conLevel["level"].gotoAndStop(1);
               conLevel["level_hero"].gotoAndStop(1);
               conLevel["panel"].addEventListener(Event.ENTER_FRAME,onPanelEnter);
               conLevel["panel"].gotoAndPlay(2);
               AnimateManager.playMcAnimate(conLevel["capsule"],_monCnt + 1,"mc_" + _monCnt,function():void
               {
                  conLevel["capsule"].gotoAndStop(1);
                  _temp = _point[_monCnt - 1];
                  loadMonster(_monID[_index],_temp[_index]);
               });
            },2000);
         }
      }
      
      private function onPanelEnter(param1:Event) : void
      {
         if(conLevel["panel"].currentFrame == 15)
         {
            conLevel["panel"]["txt"].gotoAndStop(_stage + 2);
         }
         if(conLevel["panel"].currentFrame == 106)
         {
            conLevel["panel"]["txt"].gotoAndStop(1);
         }
         if(conLevel["panel"].currentFrame == conLevel["panel"].totalFrames)
         {
            conLevel["panel"].removeEventListener(Event.ENTER_FRAME,this.onPanelEnter);
            conLevel["panel"].gotoAndStop(1);
            conLevel["leave_btn"].enabled = true;
            conLevel["leave_btn"].mouseEnabled = true;
         }
      }
      
      private function loadMonster(param1:int, param2:int) : void
      {
         var monID:int = param1;
         var temp:int = param2;
         ResourceManager.getResource(ClientConfig.getPetSwfPath(monID),function(param1:DisplayObject):void
         {
            ++_index;
            var _loc2_:MovieClip = param1 as MovieClip;
            var _loc3_:MovieClip = _container[temp] as MovieClip;
            ToolTipManager.add(_loc3_,PetXMLInfo.getName(monID));
            _loc3_.addChild(_loc2_);
            _loc3_.buttonMode = true;
            _loc3_.addEventListener(MouseEvent.CLICK,onPetClick);
            if(_monID.length > _index && _temp.length > _index)
            {
               loadMonster(_monID[_index],_temp[_index]);
            }
            else
            {
               _index = 0;
               conLevel["npc"].buttonMode = true;
               conLevel["npc"].addEventListener(MouseEvent.CLICK,onPetClick);
            }
         },"pet");
      }
      
      private function onPetClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         SocketConnection.addCmdListener(CommandID.START_KING_TOWER,function(param1:SocketEvent):void
         {
            var _loc4_:int = 0;
            _isFight = true;
            SocketConnection.removeCmdListener(CommandID.START_KING_TOWER,arguments.callee);
            _oldStage = _stage;
            _oldMonCnt = _monCnt;
            _oldMonID = _monID.concat();
            var _loc3_:ByteArray = param1.data as ByteArray;
            _stage = _loc3_.readUnsignedInt();
            _monCnt = _loc3_.readUnsignedInt();
            _monID = [];
            while(_loc4_ < MapProcess_10038._monCnt)
            {
               _monID.push(_loc3_.readUnsignedInt());
               _loc4_++;
            }
         });
         SocketConnection.send(CommandID.START_KING_TOWER);
      }
      
      private function onFightComplete(param1:PetFightEvent) : void
      {
         var info:FightOverInfo;
         var e:PetFightEvent = param1;
         _isFight = false;
         FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,this.onFightComplete);
         MainManager.actorModel.x = 484;
         MainManager.actorModel.y = 292;
         if(_type == 0)
         {
            MainManager.actorModel.showNono(NonoManager.info,MainManager.actorInfo.actionType);
         }
         info = e.dataObj as FightOverInfo;
         if(info.winnerID == MainManager.actorID)
         {
            if(_type == 1 && _stage != 0 && _stage != 20 && _stage % 10 == 0)
            {
               SpecialAlert.show(4,"恭喜你通关王者之塔，我们推荐你前往高阶战斗试炼。",function():void
               {
                  HonorsHallController.checkState();
                  HonorsHallController.openPanel(1);
               },function():void
               {
                  MapManager.addAppArrowListener(503,669,265,135);
                  MapManager.changeMap(503);
               });
               return;
            }
            if(_stage == 30)
            {
               AnimateManager.playMcAnimate(topLevel["end"],0,"",function():void
               {
                  SpecialAlert.show(1,"恭喜你通关王者之塔，我们推荐你前往勇者之塔。",function():void
                  {
                     HonorsHallController.checkState();
                     HonorsHallController.openPanel(1);
                  },function():void
                  {
                     MapManager.addAppArrowListener(465,669,265,135);
                     MapManager.changeMap(465);
                  });
               });
            }
            else
            {
               typeLevel["mc"].y = 0;
               MapManager.currentMap.makeMapArray();
               conLevel["leave_btn"].enabled = false;
               conLevel["leave_btn"].mouseEnabled = false;
               AnimateManager.playMcAnimate(conLevel["light"],2,"mc",function():void
               {
                  var _loc1_:int = 0;
                  while(_loc1_ < 6)
                  {
                     depthLevel["light_" + _loc1_].visible = true;
                     _loc1_++;
                  }
                  conLevel["door"].visible = true;
                  conLevel["leave_btn"].enabled = true;
                  conLevel["leave_btn"].mouseEnabled = true;
               });
            }
         }
         else if(info.reason == 5)
         {
            _stage = _oldStage;
            _monCnt = _oldMonCnt;
            _monID = _oldMonID.concat();
            _temp = _point[_monCnt - 1];
            this.loadMonster(_monID[_index],_temp[_index]);
         }
         else
         {
            Alarm.show("很遗憾，在这场战斗中你失败了，还需要继续磨练！",function():void
            {
               leaveFight();
            });
         }
      }
      
      private function changeFloor(param1:uint, param2:int) : void
      {
         var mte:MapTransEffect;
         var dir:uint = param1;
         var count:int = param2;
         count--;
         MainManager.actorModel.visible = false;
         if(_type == 0)
         {
            MainManager.actorModel.hideNono();
         }
         mte = new MapTransEffect(MapManager.currentMap,dir);
         mte.addEventListener(MapEvent.MAP_EFFECT_COMPLETE,function(param1:MapEvent):void
         {
            DisplayUtil.removeAllChild(LevelManager.appLevel);
            DisplayUtil.removeAllChild(LevelManager.mapLevel);
            LevelManager.mapLevel.addChild(MapManager.currentMap.root);
            MainManager.actorModel.x = 136;
            MainManager.actorModel.y = 450;
            MainManager.actorModel.visible = true;
            if(_type == 0)
            {
               MainManager.actorModel.showNono(NonoManager.info,MainManager.actorInfo.actionType);
            }
            if(count > 0)
            {
               changeFloor(dir,count);
            }
            else
            {
               initMap();
            }
         });
         mte.star();
      }
      
      public function gotoNext() : void
      {
         this.changeFloor(1,1);
      }
      
      private function onBagClick(param1:MouseEvent) : void
      {
         FightPetBagController.show();
      }
      
      private function onLeaveClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         Alert.show("确定要离开王者之塔吗？",function():void
         {
            leaveFight();
         });
      }
      
      private function leaveFight(param1:uint = 465) : void
      {
         var mapId:uint = param1;
         SocketConnection.addCmdListener(CommandID.LEAVE_KING_TOWER,function(param1:SocketEvent):void
         {
            SocketConnection.removeCmdListener(CommandID.LEAVE_KING_TOWER,arguments.callee);
            ToolBarController.panel.show();
            LevelManager.iconLevel.visible = true;
            MapManager.changeMap(mapId);
         });
         SocketConnection.send(CommandID.LEAVE_KING_TOWER);
      }
      
      override public function destroy() : void
      {
         var _loc2_:MovieClip = null;
         if(_type == 1)
         {
            MainManager.actorModel.showNono(NonoManager.info,MainManager.actorInfo.actionType);
         }
         ToolTipManager.remove(conLevel["bag_btn"]);
         ToolTipManager.remove(conLevel["leave_btn"]);
         conLevel["bag_btn"].removeEventListener(MouseEvent.CLICK,this.onBagClick);
         conLevel["leave_btn"].removeEventListener(MouseEvent.CLICK,this.onLeaveClick);
         var _loc1_:int = 0;
         while(_loc1_ < _container.length)
         {
            _loc2_ = _container[_loc1_] as MovieClip;
            ToolTipManager.remove(_loc2_);
            _loc2_.removeEventListener(MouseEvent.CLICK,this.onPetClick);
            _loc1_++;
         }
         ToolTipManager.remove(conLevel["npc"]);
         conLevel["npc"].removeEventListener(MouseEvent.CLICK,this.onPetClick);
         conLevel["panel"].removeEventListener(Event.ENTER_FRAME,this.onPanelEnter);
         FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,this.onFightComplete);
      }
   }
}

