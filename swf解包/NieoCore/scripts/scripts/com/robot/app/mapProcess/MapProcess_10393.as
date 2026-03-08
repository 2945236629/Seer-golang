package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_1850;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class MapProcess_10393 extends BaseMapProcess
   {
      
      private var _animationContainer:MovieClip;
      
      private var _currentAnimation:MovieClip;
      
      private var _currentStep:uint;
      
      public function MapProcess_10393()
      {
         super();
      }
      
      override protected function init() : void
      {
         KTool.hideMapAllPlayerAndMonster();
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         LevelManager.closeMouseEvent();
         this._animationContainer = conLevel["animationContainer"] as MovieClip;
         this._animationContainer.stop();
         this._currentAnimation = this.getAnimation(1);
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
         this._currentAnimation = this.getAnimation(param1);
         this._currentAnimation.addEventListener(Event.ENTER_FRAME,this.onAnimation);
         this._currentAnimation.gotoAndPlay(1);
      }
      
      private function stop(param1:uint) : void
      {
         this._currentAnimation = this.getAnimation(param1);
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
            NpcDialog.show(NPC.KALULU,["戈麦斯……"],["让我一个人静一下！"],[function():void
            {
               NpcDialog.show(NPC.GEMAISI,["你们都离开这里吧！让我一个人静一下。什么第六星系，什么创世神兵，都是假的！"],["戈麦斯，你不能气馁。"],[function():void
               {
                  NpcDialog.show(NPC.SAIXIAOXI,["创世之神的谜团还没有解开，你们还没有回到第六星系。一定要振作起来，创世神兵需要你！"],["索伦森！！！"],[function():void
                  {
                     _currentStep = 2;
                     start(_currentStep);
                  }]);
               }]);
            }]);
         }
         else if(this._currentStep == 2)
         {
            this.stop(3);
            NpcDialog.show(NPC.HUANGJINTIANMA,["戈麦斯，创世神兵拥有创世之神强大的力量。创世之神离开后，第六星系就全部依靠你们。而你现在竟然自暴自弃！"],["我要找索伦森报仇！"],[function():void
            {
               NpcDialog.show(NPC.LUOMULUO,["不是索伦森！虽然索伦森与我们有深仇大恨。但是达芙妮的离开的确不是索伦森。"],["你说什么？"],[function():void
               {
                  NpcDialog.show(NPC.FULUODUO,["罗慕洛的盾能够抵挡万物的攻击。索伦森根本无法攻击到我们。是那个影子，他能够瞬间穿破罗慕洛的盾形成的屏障。他应该是我们熟悉的人。"],["那会是谁呢？"],[function():void
                  {
                     _currentStep = 3;
                     start(_currentStep);
                  }]);
               }]);
            }]);
         }
         else if(this._currentStep == 3)
         {
            TaskController_1850.complete3();
         }
      }
      
      protected function getAnimation(param1:uint) : MovieClip
      {
         this._animationContainer.gotoAndStop(param1);
         return this._animationContainer["animation" + String(param1)] as MovieClip;
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

