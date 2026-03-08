package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_1005 extends BaseMapProcess
   {
      
      public function MapProcess_1005()
      {
         super();
      }
      
      override protected function init() : void
      {
         var _loc1_:BaseMapProcess = this;
         getDefinitionByName("com.robot.app2.control.BlackMiusiController").setup(_loc1_);
      }
      
      override public function destroy() : void
      {
         getDefinitionByName("com.robot.app2.control.BlackMiusiController").destroy();
      }
   }
}

