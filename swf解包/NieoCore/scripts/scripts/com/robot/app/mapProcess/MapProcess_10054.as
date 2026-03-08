package com.robot.app.mapProcess
{
   import com.robot.app.fightLevel.FightPetBagController;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.CommandID;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.dispatcher.FightDispatcher;
   import com.robot.core.event.MapEvent;
   import com.robot.core.event.PetFightEvent;
   import com.robot.core.event.RobotEvent;
   import com.robot.core.info.fightInfo.attack.FightOverInfo;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.MapTransEffect;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.mode.OgreModel;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.ui.alert.Alert;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.ByteArray;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import org.taomee.events.SocketEvent;
   import org.taomee.manager.ToolTipManager;
   import org.taomee.utils.AlignType;
   import org.taomee.utils.DisplayUtil;
   
   public class MapProcess_10054 extends BaseMapProcess
   {
      
      public static var _stage:uint;
      
      public static var _ogreId:Array;
      
      private static var _isFight:Boolean = false;
      
      private var _ogre:Array;
      
      private var _isWin:Boolean;
      
      private var _result:MovieClip;
      
      private var _pos:Array = [new Point(350,200),new Point(320,280),new Point(520,200),new Point(490,280),new Point(690,200),new Point(660,280)];
      
      public function MapProcess_10054()
      {
         super();
      }
      
      override protected function init() : void
      {
         ToolBarController.panel.hide();
         LevelManager.iconLevel.visible = false;
         ToolTipManager.add(topLevel["bag"],"精灵背包");
         topLevel["bag"].addEventListener(MouseEvent.CLICK,this.onBagClick);
         ToolTipManager.add(topLevel["exit"],"精灵学院");
         topLevel["exit"].addEventListener(MouseEvent.CLICK,this.onExitClick);
         FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,this.onFightOver);
         SocketConnection.addCmdListener(CommandID.LUOGE_WAR_NEXT_STAGE,this.onGotoNext);
         SocketConnection.addCmdListener(CommandID.LUOGE_WAR_LEAVE,this.onLeaveFight);
         if(_isFight)
         {
            topLevel["go"].visible = false;
            conLevel["door"].visible = false;
            return;
         }
         this.initMap();
      }
      
      private function onBagClick(param1:MouseEvent) : void
      {
         FightPetBagController.show();
      }
      
      private function onExitClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         Alert.show("确定要离开罗格杯竞技战吗？如果退出的话，需要从头开始挑战哦！",function():void
         {
            leaveLuogeWar(false);
         });
      }
      
      private function initMap() : void
      {
         var id_0:uint = 0;
         topLevel["go"].visible = false;
         conLevel["door"].visible = false;
         id_0 = setTimeout(function():void
         {
            var s:*;
            var id_1:* = undefined;
            clearTimeout(id_0);
            s = _stage + 1;
            if(s < 10)
            {
               topLevel["num_0"].x = 460;
               topLevel["num_0"].gotoAndStop(s + 2);
               topLevel["num_1"].gotoAndStop(1);
            }
            else
            {
               topLevel["num_0"].x = 436;
               topLevel["num_0"].gotoAndStop(uint(s / 10) + 2);
               topLevel["num_1"].gotoAndStop(uint(s % 10) + 2);
            }
            id_1 = setTimeout(function():void
            {
               clearTimeout(id_1);
               topLevel["num_0"].gotoAndStop(1);
               topLevel["num_1"].gotoAndStop(1);
            },800);
         },800);
         AnimateManager.playMcAnimate(topLevel["txt"],0,"",function():void
         {
            MainManager.actorModel.addEventListener(RobotEvent.WALK_ENTER_FRAME,onWalk);
         });
      }
      
      private function onWalk(param1:RobotEvent) : void
      {
         if(animatorLevel["shit"].hitTestPoint(MainManager.actorModel.pos.x,MainManager.actorModel.pos.y,true))
         {
            MainManager.actorModel.removeEventListener(RobotEvent.WALK_ENTER_FRAME,this.onWalk);
            this.doorAction(true,true);
         }
      }
      
      private function doorAction(param1:Boolean, param2:Boolean) : void
      {
         var id_0:uint = 0;
         var id_1:uint = 0;
         var status:Boolean = param1;
         var isPlay:Boolean = param2;
         LevelManager.closeMouseEvent();
         if(status)
         {
            if(isPlay)
            {
               animatorLevel["wall_0"].gotoAndStop(3);
               topLevel["wall_1"].gotoAndStop(3);
               topLevel["wall_2"].gotoAndStop(3);
               animatorLevel["wall_3"].gotoAndStop(3);
               id_0 = setTimeout(function():void
               {
                  clearTimeout(id_0);
                  typeLevel["block"].y = 200;
                  MapManager.currentMap.makeMapArray();
                  showOgre();
               },1000);
            }
            else
            {
               animatorLevel["wall_0"].gotoAndStop(2);
               topLevel["wall_1"].gotoAndStop(2);
               topLevel["wall_2"].gotoAndStop(2);
               animatorLevel["wall_3"].gotoAndStop(2);
               typeLevel["block"].y = 200;
               MapManager.currentMap.makeMapArray();
               this.showOgre();
            }
         }
         else if(isPlay)
         {
            animatorLevel["wall_0"].gotoAndStop(5);
            topLevel["wall_1"].gotoAndStop(5);
            topLevel["wall_2"].gotoAndStop(5);
            animatorLevel["wall_3"].gotoAndStop(5);
            id_1 = setTimeout(function():void
            {
               clearTimeout(id_1);
               typeLevel["block"].y = 0;
               MapManager.currentMap.makeMapArray();
               showOgre();
            },1000);
         }
         else
         {
            animatorLevel["wall_0"].gotoAndStop(4);
            topLevel["wall_1"].gotoAndStop(4);
            topLevel["wall_2"].gotoAndStop(4);
            animatorLevel["wall_3"].gotoAndStop(4);
            typeLevel["block"].y = 0;
            MapManager.currentMap.makeMapArray();
            this.showOgre();
         }
      }
      
      private function showOgre() : void
      {
         var _loc2_:uint = 0;
         var _loc3_:OgreModel = null;
         this._ogre = [];
         LevelManager.openMouseEvent();
         var _loc1_:uint = 0;
         while(_loc1_ < _ogreId.length)
         {
            _loc2_ = uint(_ogreId[_loc1_]);
            if(_loc2_ != 0)
            {
               _loc3_ = new OgreModel(_loc1_);
               _loc3_.show(_loc2_,this._pos[_loc1_ * 2 + uint(Math.random() * 2)]);
               _loc3_.addEventListener(MouseEvent.CLICK,this.onOgreClick);
               this._ogre.push(_loc3_);
            }
            _loc1_++;
         }
      }
      
      private function onOgreClick(param1:MouseEvent) : void
      {
         var _loc2_:OgreModel = param1.currentTarget as OgreModel;
         _ogreId[_loc2_.index] = 0;
         _isFight = true;
         SocketConnection.send(CommandID.LUOGE_WAR_FIGHT,_loc2_.id);
      }
      
      private function onFightOver(param1:PetFightEvent) : void
      {
         var id:uint = 0;
         var e:PetFightEvent = param1;
         _isFight = false;
         var info:FightOverInfo = e.dataObj as FightOverInfo;
         if(info.winnerID == MainManager.actorID)
         {
            if(_ogreId[0] == 0 && _ogreId[1] == 0 && _ogreId[2] == 0)
            {
               if(_stage == 9)
               {
                  this.leaveLuogeWar(true);
                  return;
               }
               this.doorAction(false,true);
               id = setTimeout(function():void
               {
                  clearTimeout(id);
                  topLevel["go"].visible = true;
                  conLevel["door"].visible = true;
               },1000);
            }
            else
            {
               this.doorAction(true,false);
            }
         }
         else
         {
            this.leaveLuogeWar(false);
         }
      }
      
      public function nextStage() : void
      {
         SocketConnection.send(CommandID.LUOGE_WAR_NEXT_STAGE);
      }
      
      private function onGotoNext(param1:SocketEvent) : void
      {
         var mte:MapTransEffect = null;
         var e:SocketEvent = param1;
         var b:ByteArray = e.data as ByteArray;
         _stage = b.readUnsignedInt();
         _ogreId = [];
         var i:uint = 0;
         while(i < 3)
         {
            _ogreId.push(b.readUnsignedInt());
            i++;
         }
         mte = new MapTransEffect(MapManager.currentMap,4);
         mte.addEventListener(MapEvent.MAP_EFFECT_COMPLETE,function(param1:MapEvent):void
         {
            mte.removeEventListener(MapEvent.MAP_EFFECT_COMPLETE,arguments.callee);
            MainManager.actorModel.x = 86;
            MainManager.actorModel.y = 272;
            DisplayUtil.removeAllChild(LevelManager.mapLevel);
            LevelManager.mapLevel.addChild(MapManager.currentMap.root);
            initMap();
         });
         mte.star();
      }
      
      private function leaveLuogeWar(param1:Boolean) : void
      {
         this._isWin = param1;
         _isFight = false;
         SocketConnection.send(CommandID.LUOGE_WAR_LEAVE);
      }
      
      private function onLeaveFight(param1:SocketEvent) : void
      {
         var e:SocketEvent = param1;
         var b:ByteArray = e.data as ByteArray;
         var item:uint = b.readUnsignedInt();
         var sroce:uint = b.readUnsignedInt();
         LevelManager.closeMouseEvent();
         this._result = MapManager.currentMap.libManager.getMovieClip("LuogeResultPanel_UI");
         LevelManager.appLevel.addChild(this._result);
         DisplayUtil.align(this._result,null,AlignType.MIDDLE_CENTER);
         if(this._isWin)
         {
            this._result["npc"].gotoAndStop(1);
            AnimateManager.playMcAnimate(this._result["icon"],1,"mc_1",function():void
            {
            });
         }
         else
         {
            this._result["npc"].gotoAndStop(2);
            AnimateManager.playMcAnimate(this._result["icon"],2,"mc_2",function():void
            {
            });
         }
         this._result["itemNum_0"].gotoAndStop(uint(item / 100) + 2);
         this._result["itemNum_1"].gotoAndStop(uint(item / 10) + 2);
         this._result["itemNum_2"].gotoAndStop(uint(item % 10) + 2);
         this._result["pointNum_0"].gotoAndStop(uint(sroce / 100) + 2);
         this._result["pointNum_1"].gotoAndStop(uint(sroce / 10) + 2);
         this._result["pointNum_2"].gotoAndStop(uint(sroce % 10) + 2);
         this._result["ok"].addEventListener(MouseEvent.CLICK,function():void
         {
            LevelManager.openMouseEvent();
            DisplayUtil.removeForParent(_result);
            _result["ok"].removeEventListener(MouseEvent.CLICK,arguments.callee);
            MapManager.changeMap(663);
         });
      }
      
      override public function destroy() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:OgreModel = null;
         ToolBarController.panel.show();
         LevelManager.iconLevel.visible = true;
         ToolTipManager.remove(topLevel["bag"]);
         topLevel["bag"].removeEventListener(MouseEvent.CLICK,this.onBagClick);
         ToolTipManager.remove(topLevel["exit"]);
         topLevel["exit"].removeEventListener(MouseEvent.CLICK,this.onExitClick);
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
         FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,this.onFightOver);
         SocketConnection.removeCmdListener(CommandID.LUOGE_WAR_NEXT_STAGE,this.onGotoNext);
         SocketConnection.removeCmdListener(CommandID.LUOGE_WAR_LEAVE,this.onLeaveFight);
         MainManager.actorModel.removeEventListener(RobotEvent.WALK_ENTER_FRAME,this.onWalk);
      }
   }
}

