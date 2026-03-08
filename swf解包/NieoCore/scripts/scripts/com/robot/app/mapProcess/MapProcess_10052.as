package com.robot.app.mapProcess
{
   import com.robot.app.fightLevel.FightPetBagController;
   import com.robot.app.mapProcess.control.spcaeMaze.SpaceMazeController;
   import com.robot.app.mapProcess.control.spcaeMaze.SpaceMazeMiniMap;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.config.xml.PetXMLInfo;
   import com.robot.core.dispatcher.FightDispatcher;
   import com.robot.core.event.MapEvent;
   import com.robot.core.event.PetFightEvent;
   import com.robot.core.info.fightInfo.attack.FightOverInfo;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.MapTransEffect;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.mode.OgreModel;
   import com.robot.core.ui.alert.Alarm;
   import com.robot.core.ui.alert.Alert;
   import com.robot.core.ui.alert.SimpleAlarm;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import org.taomee.events.DynamicEvent;
   import org.taomee.manager.DepthManager;
   import org.taomee.manager.ResourceManager;
   import org.taomee.manager.ToolTipManager;
   import org.taomee.utils.DisplayUtil;
   
   public class MapProcess_10052 extends BaseMapProcess
   {
      
      private var _controller:SpaceMazeController;
      
      private var _bossPos:Array = [new Point(480,220),new Point(350,260),new Point(610,260)];
      
      private var _randomPos:Array = [new Point(480,160),new Point(370,200),new Point(370,314),new Point(480,346),new Point(590,314),new Point(590,200)];
      
      private var _box:MovieClip;
      
      private var _boss:MovieClip;
      
      private var _ogre:Array;
      
      private var _eventBoss:Array;
      
      public function MapProcess_10052()
      {
         super();
      }
      
      override protected function init() : void
      {
         btnLevel.mouseEnabled = false;
         btnLevel.mouseChildren = false;
         ToolBarController.panel.hide();
         LevelManager.iconLevel.visible = false;
         ToolTipManager.add(topLevel["bag"],"精灵背包");
         topLevel["bag"].addEventListener(MouseEvent.CLICK,this.onBagClick);
         ToolTipManager.add(topLevel["exit"],"空间裂缝");
         topLevel["exit"].addEventListener(MouseEvent.CLICK,this.onExitClick);
         this._controller = SpaceMazeController.getInstance();
         if(this._controller.isFirst)
         {
            this.refreshDisplay();
            AnimateManager.playMcAnimate(topLevel["txt"],0,"",function():void
            {
            });
         }
         SpaceMazeMiniMap.show();
         FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,this.onFightOver);
      }
      
      private function onBagClick(param1:MouseEvent) : void
      {
         FightPetBagController.show();
      }
      
      private function onExitClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         Alert.show("确定要离开远古迷宫吗？如果退出的话，需要从头开始挑战哦！",function():void
         {
            leaveSpaceMaze();
         });
      }
      
      private function onFightOver(param1:PetFightEvent) : void
      {
         var info:FightOverInfo;
         var e:PetFightEvent = param1;
         if(this._controller.getRoomStatus())
         {
            this.refreshDisplay(true);
         }
         else
         {
            this.refreshDisplay();
         }
         info = e.dataObj as FightOverInfo;
         if(info.winnerID != MainManager.actorID)
         {
            Alarm.show("很遗憾，你失败了，要再接再厉哦！",function():void
            {
               leaveSpaceMaze();
            });
         }
      }
      
      private function initDoor(param1:Boolean = false) : void
      {
         var _loc2_:uint = 1;
         while(_loc2_ < 5)
         {
            if(this._controller.getDoorEnable(_loc2_))
            {
               conLevel["door_" + _loc2_].visible = true;
               if(this._controller.getDoorLimit(_loc2_))
               {
                  if(param1)
                  {
                     depthLevel["door_" + _loc2_].gotoAndStop(this._controller.getDoorType(_loc2_) * 3 + 3);
                  }
                  else
                  {
                     depthLevel["door_" + _loc2_].visible = false;
                  }
               }
               else
               {
                  depthLevel["door_" + _loc2_].visible = true;
                  if(param1)
                  {
                     depthLevel["door_" + _loc2_].gotoAndStop(this._controller.getDoorType(_loc2_) * 3 + 2);
                  }
                  else
                  {
                     depthLevel["door_" + _loc2_].gotoAndStop(this._controller.getDoorType(_loc2_) * 3 + 1);
                  }
               }
            }
            else
            {
               conLevel["door_" + _loc2_].visible = false;
               depthLevel["door_" + _loc2_].visible = false;
            }
            _loc2_++;
         }
      }
      
      private function showLight() : void
      {
         var _loc1_:uint = 1;
         while(_loc1_ < 5)
         {
            depthLevel["light_" + _loc1_].visible = true;
            _loc1_++;
         }
      }
      
      private function removeLight() : void
      {
         var _loc1_:uint = 1;
         while(_loc1_ < 5)
         {
            depthLevel["light_" + _loc1_].visible = false;
            _loc1_++;
         }
      }
      
      private function refreshDisplay(param1:Boolean = false) : void
      {
         this.initDoor(param1);
         if(this._controller.currentRoom == 13)
         {
            this.showLight();
         }
         else
         {
            this.removeLight();
         }
         switch(this._controller.currentType)
         {
            case 1:
               this.showBox();
               break;
            case 2:
               this.showBox();
               break;
            case 3:
               this.showOgre();
               break;
            case 4:
               this.showBoss();
               break;
            case 5:
               this.showRandom();
               break;
            case 6:
               this.showEventBoss();
         }
      }
      
      private function changeRoom(param1:uint) : void
      {
         var mte:MapTransEffect = null;
         var id:uint = param1;
         var i:uint = 1;
         while(i < 5)
         {
            conLevel["door_" + i].visible = false;
            i++;
         }
         mte = new MapTransEffect(MapManager.currentMap,id);
         mte.addEventListener(MapEvent.MAP_EFFECT_COMPLETE,function(param1:MapEvent):void
         {
            mte.removeEventListener(MapEvent.MAP_EFFECT_COMPLETE,arguments.callee);
            if(id == 1)
            {
               MainManager.actorModel.x = 480;
               MainManager.actorModel.y = 380;
            }
            if(id == 2)
            {
               MainManager.actorModel.x = 730;
               MainManager.actorModel.y = 260;
            }
            if(id == 3)
            {
               MainManager.actorModel.x = 480;
               MainManager.actorModel.y = 160;
            }
            if(id == 4)
            {
               MainManager.actorModel.x = 230;
               MainManager.actorModel.y = 260;
            }
            DisplayUtil.removeAllChild(LevelManager.mapLevel);
            LevelManager.mapLevel.addChild(MapManager.currentMap.root);
            _controller.addEventListener(SpaceMazeController.CHANGE_ROOM,onChangeRoom);
            _controller.changeRoom(id);
         });
         mte.star();
      }
      
      private function onChangeRoom(param1:DynamicEvent) : void
      {
         this._controller.removeEventListener(SpaceMazeController.CHANGE_ROOM,this.onChangeRoom);
         this.refreshDisplay(true);
      }
      
      private function showBox() : void
      {
         this._box = MapManager.currentMap.libManager.getMovieClip("box");
         this._box.x = 480;
         this._box.y = 225;
         this._box.buttonMode = true;
         this._box.addEventListener(MouseEvent.CLICK,this.onBoxClick);
         ToolTipManager.add(this._box,"宝箱");
         depthLevel.addChild(this._box);
         DepthManager.swapDepthAll(depthLevel);
      }
      
      private function onBoxClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         if(this._controller.currentType == 1)
         {
            AnimateManager.playMcAnimate(this._box,2,"mc_2",function():void
            {
               var key:MovieClip = null;
               if(_controller.currentItemId[0] == 1)
               {
                  key = MapManager.currentMap.libManager.getMovieClip("key_1");
               }
               if(_controller.currentItemId[0] == 2)
               {
                  key = MapManager.currentMap.libManager.getMovieClip("key_2");
               }
               topLevel.addChild(key);
               AnimateManager.playMcAnimate(key,0,"",function():void
               {
                  DisplayUtil.removeForParent(key);
                  _box.removeEventListener(MouseEvent.CLICK,onBoxClick);
                  ToolTipManager.remove(_box);
                  DisplayUtil.removeForParent(_box);
                  _box = null;
                  if(_controller.currentItemId[0] == 1)
                  {
                     SimpleAlarm.show("绿色门锁已经被打开！",true);
                  }
                  if(_controller.currentItemId[0] == 2)
                  {
                     SimpleAlarm.show("金色门锁已经被打开！",true);
                  }
                  _controller.startEvent(0);
               });
            });
         }
         if(this._controller.currentType == 2)
         {
            AnimateManager.playMcAnimate(this._box,3,"mc_3",function():void
            {
               _controller.startEvent(0);
            });
         }
      }
      
      private function showBoss() : void
      {
         var id:uint = 0;
         id = uint(this._controller.currentItemId[0]);
         if(id == 0)
         {
            return;
         }
         ResourceManager.getResource(ClientConfig.getPetSwfPath(id),function(param1:DisplayObject):void
         {
            _boss = param1 as MovieClip;
            _boss.x = 480;
            _boss.y = 220;
            _boss.buttonMode = true;
            _boss.gotoAndStop("down");
            _boss.addEventListener(MouseEvent.CLICK,onBossClick);
            ToolTipManager.add(_boss,PetXMLInfo.getName(id));
            depthLevel.addChild(_boss);
            DepthManager.swapDepthAll(depthLevel);
         },"pet");
      }
      
      private function onBossClick(param1:MouseEvent) : void
      {
         this._controller.startEvent(0);
      }
      
      private function showOgre() : void
      {
         var _loc2_:uint = 0;
         var _loc3_:OgreModel = null;
         this._ogre = [];
         var _loc1_:uint = 0;
         while(_loc1_ < this._controller.currentItemId.length)
         {
            _loc2_ = uint(this._controller.currentItemId[_loc1_]);
            if(_loc2_ != 0)
            {
               _loc3_ = new OgreModel(_loc1_);
               _loc3_.show(_loc2_,this._randomPos[_loc1_ * 2 + uint(Math.random() * 2)]);
               _loc3_.addEventListener(MouseEvent.CLICK,this.onOgreClick);
               this._ogre.push(_loc3_);
            }
            _loc1_++;
         }
      }
      
      private function onOgreClick(param1:MouseEvent) : void
      {
         var _loc2_:OgreModel = param1.currentTarget as OgreModel;
         this._controller.startEvent(_loc2_.index);
      }
      
      private function showRandom() : void
      {
         if(this._controller.currentItemId[0] == 2)
         {
            AnimateManager.playFullScreenAnimate(ClientConfig.getFullMovie("spaceMaze"),function():void
            {
               leaveSpaceMaze();
            });
         }
      }
      
      private function showEventBoss() : void
      {
         var _loc2_:uint = 0;
         this._eventBoss = [];
         var _loc1_:uint = 0;
         while(_loc1_ < this._controller.currentItemId.length)
         {
            _loc2_ = uint(this._controller.currentItemId[_loc1_]);
            if(_loc2_ != 0)
            {
               this.loadBoss(this._controller.currentItemId[_loc1_],this._bossPos[_loc1_],_loc1_);
            }
            _loc1_++;
         }
      }
      
      private function loadBoss(param1:uint, param2:Point, param3:uint) : void
      {
         var id:uint = param1;
         var pos:Point = param2;
         var index:uint = param3;
         ResourceManager.getResource(ClientConfig.getPetSwfPath(id),function(param1:DisplayObject):void
         {
            var _loc2_:MovieClip = param1 as MovieClip;
            _loc2_.name = "boss_" + index;
            _loc2_.x = pos.x;
            _loc2_.y = pos.y;
            _loc2_.buttonMode = true;
            _loc2_.gotoAndStop("down");
            _loc2_.addEventListener(MouseEvent.CLICK,onEventBossClick);
            ToolTipManager.add(_loc2_,PetXMLInfo.getName(id));
            depthLevel.addChild(_loc2_);
            DepthManager.swapDepthAll(depthLevel);
         },"pet");
      }
      
      private function onEventBossClick(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         this._controller.startEvent(uint(_loc2_.name.split("_")[1]));
      }
      
      public function changeRoom_1() : void
      {
         if(this._controller.getDoorLimit(1))
         {
            this.changeRoom(1);
         }
         else
         {
            SimpleAlarm.show(this._controller.getDoorTip(1),true);
         }
      }
      
      public function changeRoom_2() : void
      {
         if(this._controller.getDoorLimit(2))
         {
            this.changeRoom(2);
         }
         else
         {
            SimpleAlarm.show(this._controller.getDoorTip(2),true);
         }
      }
      
      public function changeRoom_3() : void
      {
         if(this._controller.getDoorLimit(3))
         {
            this.changeRoom(3);
         }
         else
         {
            SimpleAlarm.show(this._controller.getDoorTip(3),true);
         }
      }
      
      public function changeRoom_4() : void
      {
         if(this._controller.getDoorLimit(4))
         {
            this.changeRoom(4);
         }
         else
         {
            SimpleAlarm.show(this._controller.getDoorTip(4),true);
         }
      }
      
      private function leaveSpaceMaze() : void
      {
         this._controller.leave();
      }
      
      override public function destroy() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:OgreModel = null;
         var _loc3_:uint = 0;
         var _loc4_:MovieClip = null;
         ToolBarController.panel.show();
         LevelManager.iconLevel.visible = true;
         ToolTipManager.remove(topLevel["bag"]);
         topLevel["bag"].removeEventListener(MouseEvent.CLICK,this.onBagClick);
         ToolTipManager.remove(topLevel["exit"]);
         topLevel["exit"].removeEventListener(MouseEvent.CLICK,this.onExitClick);
         SpaceMazeMiniMap.destroy();
         FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,this.onFightOver);
         if(this._box)
         {
            this._box.removeEventListener(MouseEvent.CLICK,this.onBoxClick);
            ToolTipManager.remove(this._box);
            DisplayUtil.removeForParent(this._box);
         }
         if(this._boss)
         {
            this._boss.removeEventListener(MouseEvent.CLICK,this.onBossClick);
            ToolTipManager.remove(this._boss);
            DisplayUtil.removeForParent(this._boss);
         }
         if(this._ogre)
         {
            _loc1_ = 0;
            while(_loc1_ < this._ogre.length)
            {
               _loc2_ = this._ogre[_loc1_] as OgreModel;
               _loc2_.removeEventListener(MouseEvent.CLICK,this.onOgreClick);
               _loc2_.destroy();
               _loc1_++;
            }
         }
         if(this._eventBoss)
         {
            _loc3_ = 0;
            while(_loc3_ < this._eventBoss.length)
            {
               _loc4_ = this._eventBoss[_loc3_] as MovieClip;
               _loc4_.removeEventListener(MouseEvent.CLICK,this.onEventBossClick);
               ToolTipManager.remove(_loc4_);
               DisplayUtil.removeForParent(_loc4_);
               _loc3_++;
            }
         }
      }
   }
}

