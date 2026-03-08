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
   
   public class MapProcess_10392 extends BaseMapProcess
   {
      
      private var _animationContainer:MovieClip;
      
      private var _currentAnimation:MovieClip;
      
      private var _currentStep:uint;
      
      public function MapProcess_10392()
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
         NpcDialog.show(NPC.LUOMULUO,["索伦森吸收了五大星系的能量，现在实力大增！五星系的任何一个地方都能够被他找到！这里已经不安全了！"],["泽尼森也是他们派来的？"],[function():void
         {
            NpcDialog.show(NPC.GEMAISI,["应该不是！他的气息完全跟索伦森不同。我们背后应该还隐藏着更强大的敌人！"],["你是说？"],[function():void
            {
               NpcDialog.show(NPC.GEMAISI,["我不敢确认，但是罗慕洛，我们必须尽快找到其他的神兵，才能够进入第六星系。"],["天下之大该去哪里寻找？"],[function():void
               {
                  NpcDialog.show(NPC.FULUODUO,["现在梦境之神也离开了！我们根本没有任何线索！"],["小心！"],[function():void
                  {
                     _currentStep = 1;
                     start(_currentStep);
                  }]);
               }]);
            }]);
         }]);
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
            NpcDialog.show(NPC.SUOLUOSENG,["又是你们？赫尔墨斯去哪里了？ 害怕了？吓破胆了？躲起来了！哈哈哈！"],["狂妄的家伙！"],[function():void
            {
               NpcDialog.show(NPC.SUOLUOSENG,["这是我与他们四个虚伪的家伙的恩怨，你们最好不要插手！"],["是你害死了创世之神。"],[function():void
               {
                  NpcDialog.show(NPC.DAFUNI,["一切都是因为你！我们怎么能够不插手！索伦森，今天就让我们了结星系的恩怨吧！"],["敬酒不吃吃罚酒！"],[function():void
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
            NpcDialog.show(NPC.GEMAISI,["达芙妮！！！弗罗多，快！赶紧救救达芙妮！"],["让我来！"],[function():void
            {
               NpcDialog.show(NPC.GEMAISI,["卑鄙的索伦森，我不会放过你！"],["刚刚那是谁？"],[function():void
               {
                  _currentStep = 3;
                  start(_currentStep);
               }]);
            }]);
         }
         else if(this._currentStep == 3)
         {
            this.stop(4);
            NpcDialog.show(NPC.FULUODUO,["对不起，我……我尽力了！"],["不可能！ "],[function():void
            {
               NpcDialog.show(NPC.GEMAISI,["你不是拥有最厉害的治愈能力吗？对！赫拉，赫拉！我们快去找赫拉！"],["不用了！"],[function():void
               {
                  NpcDialog.show(NPC.DAFUNI,["戈麦斯，你们……你们一定要坚持下去。早日……早日找到……第六星系！"],["达芙妮！"],[function():void
                  {
                     _currentStep = 4;
                     start(_currentStep);
                  }]);
               }]);
            }]);
         }
         else if(this._currentStep == 4)
         {
            TaskController_1850.complete2();
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

