package com.robot.app.mapProcess
{
   import com.robot.core.aimat.*;
   import com.robot.core.event.*;
   import com.robot.core.manager.*;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.ui.alert.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   
   public class MapProcess_453 extends BaseMapProcess
   {
      
      private static var firetime:Array = [0,0,0,0,0];
      
      private var lightTime:uint = 90;
      
      private var timer:Timer;
      
      private var haveFire:Boolean;
      
      private var lightArr:Array = [];
      
      private var circleArr:Array = [];
      
      private var seerCircle:MovieClip;
      
      public function MapProcess_453()
      {
         super();
      }
      
      override protected function init() : void
      {
         this.conLevel["firstMC"].visible = false;
         this.conLevel["petMC"].visible = false;
         this.initForAll();
      }
      
      override public function destroy() : void
      {
         this.destroyForAll();
      }
      
      private function initForAll() : void
      {
         var _loc3_:MovieClip = null;
         var _loc5_:uint = 0;
         var _loc1_:MovieClip = null;
         var _loc2_:MovieClip = null;
         _loc3_ = null;
         var _loc4_:MovieClip = this.topLevel["backBig"];
         _loc4_.alpha = 0.65;
         _loc4_.blendMode = BlendMode.MULTIPLY;
         _loc4_.cacheAsBitmap = false;
         _loc5_ = 1;
         while(_loc5_ <= 5)
         {
            _loc1_ = this.conLevel["lightMC" + _loc5_];
            if(_loc5_ == 5)
            {
               _loc1_.gotoAndStop(2);
            }
            else
            {
               _loc1_.gotoAndStop(1);
               _loc1_.buttonMode = true;
               _loc1_.addEventListener(MouseEvent.CLICK,this.checkFireHandler);
               this.lightArr.push(_loc1_);
            }
            _loc3_ = this.topLevel["backBig"]["backMC" + _loc5_];
            _loc2_ = MapManager.currentMap.libManager.getMovieClip("LightCircle");
            _loc2_.width = _loc3_.width;
            _loc2_.height = _loc3_.height;
            _loc2_.x = _loc3_.x;
            _loc2_.y = _loc3_.y;
            if(_loc5_ == 5)
            {
               _loc2_.visible = true;
            }
            else
            {
               _loc2_.visible = false;
               this.circleArr.push(_loc2_);
            }
            _loc2_.mouseChildren = _loc2_.mouseEnabled = false;
            this.topLevel.addChild(_loc2_);
            _loc3_.gotoAndStop(1);
            _loc5_++;
         }
         this.seerCircle = MapManager.currentMap.libManager.getMovieClip("LightCircle");
         this.seerCircle.scaleX = 2;
         this.seerCircle.scaleY = 2;
         this.seerCircle.x = MainManager.actorModel.pos.x - this.seerCircle.width * 0.5;
         this.seerCircle.y = MainManager.actorModel.pos.y - this.seerCircle.height * 0.5;
         this.seerCircle.mouseChildren = this.seerCircle.mouseEnabled = false;
         this.topLevel.addChild(this.seerCircle);
         this.checkHaveFire();
         this.timer = new Timer(1000);
         this.timer.addEventListener(TimerEvent.TIMER,this.timerHandler);
         this.timer.start();
         AimatController.addEventListener(AimatEvent.PLAY_END,this.onAimatEnd);
         MainManager.actorModel.addEventListener(RobotEvent.WALK_ENTER_FRAME,this.walkHandler);
      }
      
      private function checkHaveFire() : void
      {
         if(MainManager.actorInfo.clothIDs.indexOf(100044) == -1)
         {
            ItemManager.addEventListener(ItemEvent.CLOTH_LIST,function(param1:ItemEvent):void
            {
               if(!ItemManager.containsCloth(100044))
               {
                  haveFire = false;
               }
               else
               {
                  haveFire = true;
               }
               ItemManager.removeEventListener(ItemEvent.CLOTH_LIST,arguments.callee);
            });
            ItemManager.getCloth();
         }
         else
         {
            this.haveFire = true;
         }
      }
      
      private function destroyForAll() : void
      {
         var _loc1_:MovieClip = null;
         MainManager.actorModel.removeEventListener(RobotEvent.WALK_ENTER_FRAME,this.walkHandler);
         AimatController.removeEventListener(AimatEvent.PLAY_END,this.onAimatEnd);
         if(Boolean(this.timer))
         {
            this.timer.removeEventListener(TimerEvent.TIMER,this.timerHandler);
            this.timer.stop();
            this.timer = null;
         }
         var _loc2_:uint = 0;
         while(_loc2_ < this.lightArr.length)
         {
            _loc1_ = this.lightArr[_loc2_];
            _loc1_.removeEventListener(MouseEvent.CLICK,this.checkFireHandler);
            _loc2_++;
         }
         this.lightArr.length = 0;
         this.lightArr = null;
         this.circleArr.length = 0;
         this.circleArr = null;
      }
      
      private function checkFireHandler(param1:MouseEvent = null) : void
      {
         if(!this.haveFire)
         {
            Alarm.show("用火焰喷射器射击才能点燃灯火, 你的背包内没有火焰喷射器，到机械室可以领取");
         }
         else if(MainManager.actorInfo.clothIDs.indexOf(100044) == -1)
         {
            Alarm.show("装备火焰喷射器射击点燃灯火");
         }
         else
         {
            Alarm.show("用火焰喷射器射击点燃灯火");
         }
      }
      
      private function walkHandler(param1:RobotEvent) : void
      {
         if(Boolean(this.seerCircle) && Boolean(MainManager.actorModel.visible))
         {
            this.seerCircle.x = MainManager.actorModel.pos.x - this.seerCircle.width * 0.5;
            this.seerCircle.y = MainManager.actorModel.pos.y - this.seerCircle.height * 0.5;
         }
      }
      
      private function onAimatEnd(param1:AimatEvent) : void
      {
         var _loc2_:MovieClip = null;
         if(param1.info.userID != MainManager.actorID)
         {
            return;
         }
         var _loc3_:Point = param1.info.endPos;
         var _loc5_:uint = 0;
         while(_loc5_ < this.lightArr.length)
         {
            _loc2_ = this.lightArr[_loc5_];
            if(Point.distance(MainManager.actorModel.pos,new Point(_loc2_.x,_loc2_.y)) < 200)
            {
               if(_loc2_.hitTestPoint(_loc3_.x,_loc3_.y))
               {
                  if(MainManager.actorInfo.clothIDs.indexOf(100044) == -1)
                  {
                     this.checkFireHandler();
                     return;
                  }
                  var _loc4_:Boolean = false;
                  firetime[_loc5_] = getTimer();
                  _loc2_.gotoAndStop(2);
                  _loc2_.mouseEnabled = false;
                  _loc2_.mouseChildren = false;
                  break;
               }
            }
            _loc5_++;
         }
         Alarm.show("只有走近灯火，才能用火焰喷射器将其点燃哦！");
      }
      
      private function timerHandler(param1:TimerEvent) : void
      {
         var _loc2_:int = int(getTimer());
         var _loc3_:uint = 0;
         while(_loc3_ < this.lightArr.length)
         {
            if(firetime[_loc3_] > 0)
            {
               if(_loc2_ - firetime[_loc3_] > this.lightTime * 1000)
               {
                  this.closeLight(_loc3_);
               }
               else
               {
                  this.openLight(_loc3_);
               }
            }
            _loc3_++;
         }
      }
      
      private function closeLight(param1:uint) : void
      {
         firetime[param1] = 0;
         var _loc2_:MovieClip = this.lightArr[param1];
         if(_loc2_.currentFrame != 1)
         {
            _loc2_.gotoAndStop(1);
            _loc2_.mouseEnabled = true;
            _loc2_.mouseChildren = true;
         }
         this.circleArr[param1].visible = false;
         this.topLevel["backBig"]["backMC" + (param1 + 1)].gotoAndStop(1);
      }
      
      private function openLight(param1:uint) : void
      {
         var _loc2_:MovieClip = this.lightArr[param1];
         if(_loc2_.currentFrame != 2)
         {
            _loc2_.gotoAndStop(2);
         }
         this.circleArr[param1].visible = true;
         this.topLevel["backBig"]["backMC" + (param1 + 1)].gotoAndStop(2);
      }
   }
}

