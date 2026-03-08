package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1850;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class MapProcess_10394 extends BaseMapProcess
   {
      
      private var _animationContainer:MovieClip;
      
      private var _currentAnimation:MovieClip;
      
      private var _currentStep:uint;
      
      public function MapProcess_10394()
      {
         super();
      }
      
      override protected function init() : void
      {
         KTool.hideMapAllPlayerAndMonster();
         LevelManager.closeMouseEvent();
         this._animationContainer = conLevel["animationContainer"] as MovieClip;
         this._currentAnimation = this.getAnimationAndRender(1);
         this._currentAnimation.stop();
         this._currentStep = 1;
         this.start(this._currentStep);
      }
      
      private function checkEnd(param1:MovieClip) : Boolean
      {
         if(param1.currentFrame == param1.totalFrames)
         {
            return true;
         }
         return false;
      }
      
      private function start(param1:uint) : void
      {
         LevelManager.closeMouseEvent();
         this._currentAnimation = this.getAnimationAndRender(param1);
         this._currentAnimation.addEventListener(Event.ENTER_FRAME,this.onAnimation);
         this._currentAnimation.gotoAndPlay(1);
      }
      
      private function stop(param1:uint) : void
      {
         this._currentAnimation = this.getAnimationAndRender(param1);
         this._currentAnimation.gotoAndStop(1);
      }
      
      private function onAnimation(param1:Event) : void
      {
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         if(this.checkEnd(_loc2_))
         {
            this.onAnimationEnd();
         }
      }
      
      private function onAnimationEnd() : void
      {
         this._currentAnimation.removeEventListener(Event.ENTER_FRAME,this.onAnimation);
         this._currentAnimation.stop();
         if(this._currentStep == 1)
         {
            this.stop(2);
            NpcDialog.show(NPC.HUANGJINTIANMA,["这里的气息……为什么我会感觉到创世之神的力量？"],["什么？"],[function():void
            {
               NpcDialog.show(NPC.GEMAISI,["达芙妮为什么带我们来这里却突然消失了？难道我们看到的是幻象？这里是哪里？"],["事情的确很蹊跷！"],[function():void
               {
                  NpcDialog.show(NPC.FULUODUO,["圣翼之灵把我们带来这里，一定会有什么原因！我们四周找找看！"],["快看！"],[function():void
                  {
                     _currentStep = 2;
                     start(_currentStep);
                  }]);
               }]);
            }]);
         }
         else if(this._currentStep == 2)
         {
            NpcDialog.show(NPC.HUANGJINTIANMA,["你是何人？圣翼之灵为什么又会出现。她不是已经……"],["我乃第六星系战将奥斯卡。"],[function():void
            {
               playerTask1850_0Animation();
            }]);
         }
         else if(this._currentStep == 3)
         {
            LevelManager.closeMouseEvent();
            AnimateManager.playFullScreenAnimate(ClientConfig.getFullMovie("task_1850_1"),function():void
            {
               TaskController_1850.complete4();
            });
         }
      }
      
      protected function playerTask1850_0Animation() : void
      {
         LevelManager.closeMouseEvent();
         AnimateManager.playFullScreenAnimate(ClientConfig.getFullMovie("task_1850_0"),function():void
         {
            playerTask1850_0AnimationEnd();
         });
      }
      
      protected function playerTask1850_0AnimationEnd() : void
      {
         NpcDialog.show(NPC.AOSIKA,["我奉命追拿索伦森回第六星系接受万世囚禁！至于你们为何来此，我不便多说！这次我一定要带索伦森回去！"],["既然如此！"],[function():void
         {
            NpcDialog.show(NPC.GEMAISI,["作为继承创世之神能量的神兵们，让我们一起与奥斯卡击败索伦森，重返第六星系！还第六星系的太平盛世！"],["好！！！"],[function():void
            {
               _currentStep = 3;
               start(_currentStep);
            }]);
         }]);
      }
      
      protected function getAnimation(param1:uint) : MovieClip
      {
         this._animationContainer.gotoAndStop(param1);
         return this._animationContainer["animation" + String(param1)] as MovieClip;
      }
      
      protected function getAnimationAndRender(param1:uint) : MovieClip
      {
         var _loc2_:MovieClip = null;
         this.hideAnimationContainerAllChildren();
         _loc2_ = this._animationContainer["animation" + String(param1)] as MovieClip;
         _loc2_.visible = true;
         return _loc2_;
      }
      
      protected function hideAnimationContainerAllChildren() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._animationContainer.numChildren)
         {
            this._animationContainer.getChildAt(_loc1_).visible = false;
            MovieClip(this._animationContainer.getChildAt(_loc1_)).gotoAndStop(1);
            _loc1_++;
         }
      }
      
      override public function destroy() : void
      {
         LevelManager.openMouseEvent();
         super.destroy();
         if(this._currentAnimation)
         {
            this._currentAnimation.stop();
            this._currentAnimation = null;
         }
         if(this._animationContainer)
         {
            this._animationContainer.stop();
            this._animationContainer = null;
         }
      }
   }
}

