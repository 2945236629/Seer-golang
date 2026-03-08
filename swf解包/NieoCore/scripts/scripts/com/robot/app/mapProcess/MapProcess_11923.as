package com.robot.app.mapProcess
{
   import com.robot.app.mapProcess.control.BiSuoKongJianMapController;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_11923 extends BaseMapProcess
   {
      
      private var control:BiSuoKongJianMapController;
      
      public function MapProcess_11923()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         this.control = new BiSuoKongJianMapController();
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

