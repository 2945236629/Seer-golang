package com.robot.app.mapProcess
{
   import com.robot.app.control.*;
   import com.robot.app.mapProcess.control.*;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.events.*;
   import org.taomee.manager.*;
   
   public class MapProcess_695 extends BaseMapProcess
   {
      
      public function MapProcess_695()
      {
         super();
      }
      
      override protected function init() : void
      {
         conLevel["machine"].buttonMode = true;
         conLevel["machine"].addEventListener(MouseEvent.CLICK,this.onMachineTree);
         ToolTipManager.add(conLevel["machine"],"精灵修炼器");
         ChuangShiShenBingController.instance.start();
      }
      
      private function onMachineTree(param1:Event) : void
      {
         PetPracticeController.start();
      }
      
      override public function destroy() : void
      {
         ToolTipManager.remove(conLevel["machine"]);
         conLevel["machine"].removeEventListener(MouseEvent.CLICK,this.onMachineTree);
      }
   }
}

