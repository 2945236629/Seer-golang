package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   import org.taomee.manager.ToolTipManager;
   
   public class MapProcess_817 extends BaseMapProcess
   {
      
      public function MapProcess_817()
      {
         super();
      }
      
      override protected function init() : void
      {
         getDefinitionByName("com.robot.app2.mapProcess.control.activityControl.FindBuildingBlockCityControl").initForMap817();
         (conLevel["doorMC"] as MovieClip).addEventListener(MouseEvent.CLICK,this.clickDoorFun);
         (conLevel["doorMC"] as MovieClip).buttonMode = true;
         ToolTipManager.add(conLevel["doorMC"],"前往沙滩乐园");
      }
      
      override public function destroy() : void
      {
         (conLevel["doorMC"] as MovieClip).removeEventListener(MouseEvent.CLICK,this.clickDoorFun);
         ToolTipManager.remove(conLevel["doorMC"]);
         getDefinitionByName("com.robot.app2.mapProcess.control.activityControl.FindBuildingBlockCityControl").destoryFor817();
         super.destroy();
      }
      
      private function clickDoorFun(param1:MouseEvent) : void
      {
         (conLevel["doorMC"]["door"] as MovieClip).play();
      }
   }
}

