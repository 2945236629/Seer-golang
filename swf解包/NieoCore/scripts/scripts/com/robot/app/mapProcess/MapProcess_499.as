package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.events.*;
   import org.taomee.manager.*;
   
   public class MapProcess_499 extends BaseMapProcess
   {
      
      public function MapProcess_499()
      {
         super();
      }
      
      override protected function init() : void
      {
         ToolTipManager.add(depthLevel["signup"],"星空擂台");
         depthLevel["signup"].buttonMode = true;
         depthLevel["signup"].addEventListener(MouseEvent.CLICK,this.onSignUp);
      }
      
      private function onSignUp(param1:MouseEvent) : void
      {
      }
      
      override public function destroy() : void
      {
         ToolTipManager.remove(depthLevel["signup"]);
         depthLevel["signup"].removeEventListener(MouseEvent.CLICK,this.onSignUp);
      }
   }
}

