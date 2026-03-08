package com.robot.app.mapProcess
{
   import com.robot.app.mapProcess.control.BiSuoKongJianMainMapController;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_11925 extends BaseMapProcess
   {
      
      private var control:BiSuoKongJianMainMapController;
      
      public function MapProcess_11925()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         this.control = new BiSuoKongJianMainMapController();
         this.control.setUp(this);
      }
      
      override public function destroy() : void
      {
         if(this.control)
         {
            this.control.destroy();
            this.control = null;
         }
         super.destroy();
      }
   }
}

