package com.robot.app.mapProcess
{
   import com.robot.app.toolBar.*;
   import com.robot.core.manager.*;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   
   public class MapProcess_409 extends BaseMapProcess
   {
      
      private var _userActorMc:MovieClip;
      
      private var _mcArr:Array;
      
      private var _genArr:Array;
      
      private var _door_0:MovieClip;
      
      private var _timer:Timer;
      
      private var _genCount:uint;
      
      private var _ballBtn:MovieClip;
      
      private var isTurnOff:Boolean = false;
      
      private var _goMc:MovieClip;
      
      private var _doorMc:MovieClip;
      
      private var _btn_0:MovieClip;
      
      private var bmp:Bitmap;
      
      private var _isLighting:Boolean = false;
      
      public function MapProcess_409()
      {
         super();
      }
      
      override protected function init() : void
      {
         var _loc1_:MovieClip = null;
         this._door_0 = this.conLevel["door_0"];
         this._ballBtn = this.conLevel["ballBtn"];
         this._goMc = this.conLevel["goMc"];
         this._doorMc = this.conLevel["doorMc"];
         this._btn_0 = this.conLevel["btn_0"];
         this._goMc.visible = false;
         this._door_0.visible = false;
         this._doorMc.visible = false;
         this._mcArr = new Array();
         this._genArr = new Array();
         var _loc2_:int = 1;
         while(_loc2_ < 7)
         {
            this._mcArr.push(this.depthLevel["mc_" + _loc2_]);
            _loc2_++;
         }
         var _loc3_:int = 1;
         while(_loc3_ < 7)
         {
            this._genArr.push(this.conLevel["gen_" + _loc3_]);
            _loc3_++;
         }
         for each(_loc1_ in this._mcArr)
         {
            _loc1_.gotoAndStop(21);
         }
         this._genCount = 1;
         this._timer = new Timer(1000);
         this._timer.addEventListener(TimerEvent.TIMER,this.onTimerHandler);
         this._timer.start();
         this._userActorMc = MainManager.actorModel.skeleton.getSkeletonMC();
         this.addEvent();
         ToolBarController.showOrHideAllUser(false);
      }
      
      private function onTimerHandler(param1:TimerEvent) : void
      {
         var _loc2_:MovieClip = null;
         ++this._genCount;
         if(this._genCount >= 7)
         {
            this._genCount = 1;
         }
         for each(_loc2_ in this._mcArr)
         {
            _loc2_.gotoAndStop(21);
         }
         (depthLevel["mc_" + this._genCount] as MovieClip).gotoAndPlay(1);
      }
      
      private function addEvent() : void
      {
         if(Boolean(this._userActorMc))
         {
            this._userActorMc.addEventListener(Event.ENTER_FRAME,this.onAtorHitTest);
         }
         if(Boolean(this._btn_0))
         {
            this._btn_0.addEventListener(MouseEvent.ROLL_OVER,this.onOverHandler);
            this._btn_0.addEventListener(MouseEvent.ROLL_OUT,this.onOutHandler);
         }
      }
      
      private function onOverHandler(param1:MouseEvent) : void
      {
         if(!this.isTurnOff)
         {
            this._ballBtn.gotoAndStop(2);
         }
      }
      
      private function onOutHandler(param1:MouseEvent) : void
      {
         if(!this.isTurnOff)
         {
            this._ballBtn.gotoAndStop(1);
         }
      }
      
      private function removeEvent() : void
      {
         if(Boolean(this._userActorMc))
         {
            this._userActorMc.removeEventListener(Event.ENTER_FRAME,this.onAtorHitTest);
         }
         if(Boolean(this._btn_0))
         {
            this._btn_0.removeEventListener(MouseEvent.ROLL_OVER,this.onOverHandler);
            this._btn_0.removeEventListener(MouseEvent.ROLL_OUT,this.onOutHandler);
         }
      }
      
      private function onAtorHitTest(param1:Event) : void
      {
         var t:uint = 0;
         var _mc:MovieClip = null;
         var rec:Rectangle = null;
         t = 0;
         var evt:Event = param1;
         if(!this._isLighting)
         {
            for each(_mc in this._mcArr)
            {
               rec = new Rectangle(MainManager.actorModel.pos.x,MainManager.actorModel.pos.y,this._userActorMc.width,this._userActorMc.height);
               if(Boolean(_mc["hitmc"]))
               {
                  if(this._userActorMc.hitTestObject(_mc["hitmc"]))
                  {
                     this._isLighting = true;
                     LevelManager.closeMouseEvent();
                     MainManager.actorModel.walk.stop();
                     t = uint(setTimeout(function():void
                     {
                        clearTimeout(t);
                        _isLighting = false;
                        LevelManager.openMouseEvent();
                     },300));
                     break;
                  }
               }
            }
         }
      }
      
      public function onBtnHandler() : void
      {
         this.onClickBallHandler();
         this._timer.stop();
         this._goMc.visible = true;
         this._door_0.visible = true;
         this._doorMc.visible = true;
         this.isTurnOff = true;
         this._ballBtn.addEventListener(Event.ENTER_FRAME,function():void
         {
            var _loc2_:MovieClip = null;
            if(Boolean(_ballBtn["b3"]))
            {
               _loc2_ = _ballBtn["b3"];
               if(_loc2_.currentFrame == _loc2_.totalFrames)
               {
                  _ballBtn.removeEventListener(Event.ENTER_FRAME,arguments.callee);
                  _loc2_.visible = false;
               }
            }
         });
         this._ballBtn.gotoAndStop(3);
         if(Boolean(this._userActorMc))
         {
            this._userActorMc.removeEventListener(Event.ENTER_FRAME,this.onAtorHitTest);
         }
      }
      
      private function onClickBallHandler(param1:MouseEvent = null) : void
      {
         var _mcGen:MovieClip = null;
         var _mc:MovieClip = null;
         _mcGen = null;
         var e:MouseEvent = param1;
         for each(_mc in this._mcArr)
         {
            _mc.gotoAndStop(21);
         }
         for each(_mcGen in this._genArr)
         {
            _mcGen.addEventListener(Event.ENTER_FRAME,function(param1:Event):void
            {
               if(_mcGen.currentFrame == _mcGen.totalFrames)
               {
                  _mcGen.gotoAndStop(_mcGen.totalFrames);
               }
            });
            _mcGen.gotoAndPlay(2);
         }
      }
      
      override public function destroy() : void
      {
         ToolBarController.showOrHideAllUser(true);
         this.removeEvent();
      }
   }
}

