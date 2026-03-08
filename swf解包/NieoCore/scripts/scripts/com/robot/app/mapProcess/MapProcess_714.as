package com.robot.app.mapProcess
{
   import com.robot.app.mapProcess.control.YiJieSpaceController;
   import com.robot.core.manager.SystemTimerManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_714 extends BaseMapProcess
   {
      
      public function MapProcess_714()
      {
         super();
      }
      
      public static function isInActive() : Boolean
      {
         var _loc1_:Date = SystemTimerManager.sysDate;
         if(_loc1_.hours == 15)
         {
            if(_loc1_.month == 11 && _loc1_.date == 1)
            {
               return true;
            }
         }
         return false;
      }
      
      override protected function init() : void
      {
         YiJieSpaceController.init(this);
      }
      
      override public function destroy() : void
      {
         YiJieSpaceController.destory();
         super.destroy();
      }
   }
}

