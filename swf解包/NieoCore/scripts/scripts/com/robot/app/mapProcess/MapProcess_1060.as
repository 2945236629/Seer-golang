package com.robot.app.mapProcess
{
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.events.MouseEvent;
   
   public class MapProcess_1060 extends BaseMapProcess
   {
      
      public function MapProcess_1060()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         conLevel.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      override public function destroy() : void
      {
         conLevel.removeEventListener(MouseEvent.CLICK,this.onClick);
         super.destroy();
      }
      
      protected function onClick(param1:MouseEvent) : void
      {
         var _loc2_:String = param1.target.name;
         switch(_loc2_)
         {
            case "NPC":
               ModuleManager.showAppModule("SpringFestival2022_SummaryPanel");
         }
      }
   }
}

