package com.robot.app.mapProcess
{
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class MapProcess_1621 extends BaseMapProcess
   {
      
      public function MapProcess_1621()
      {
         super();
      }
      
      override protected function init() : void
      {
         animatorLevel["gotoAndStop"](1);
         conLevel["door"].addEventListener(MouseEvent.CLICK,this.onClick);
         conLevel["door"].enabled = true;
         conLevel["door"].visible = true;
      }
      
      protected function onClick(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         if((animatorLevel as MovieClip).currentFrame == 1)
         {
            animatorLevel["gotoAndStop"](2);
            LevelManager.closeAllMouseEvent();
            AnimateManager.playMcAnimate(animatorLevel["mc"],1,"",function():void
            {
               animatorLevel["gotoAndStop"](3);
               LevelManager.openMouseEvent();
               conLevel["door"].enabled = false;
               conLevel["door"].removeEventListener(MouseEvent.CLICK,onClick);
               conLevel["door"].visible = false;
            });
         }
      }
      
      override public function destroy() : void
      {
         conLevel["door"].removeEventListener(MouseEvent.CLICK,this.onClick);
         super.destroy();
      }
   }
}

