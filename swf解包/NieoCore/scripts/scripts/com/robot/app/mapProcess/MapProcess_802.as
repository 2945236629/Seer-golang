package com.robot.app.mapProcess
{
   import com.robot.app.mapProcess.control.WBSpaceController;
   import com.robot.core.manager.SystemTimerManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_802 extends BaseMapProcess
   {
      
      public function MapProcess_802()
      {
         super();
      }
      
      public static function isInActive() : Boolean
      {
         var _loc1_:Date = SystemTimerManager.sysDate;
         if(_loc1_.hours == 13)
         {
            if(_loc1_.month == 10 && _loc1_.date == 30)
            {
               return true;
            }
            if(_loc1_.month == 11 && _loc1_.date <= 2)
            {
               return true;
            }
         }
         return false;
      }
      
      override protected function init() : void
      {
         WBSpaceController.init(this);
      }
      
      override public function destroy() : void
      {
         WBSpaceController.destory();
         super.destroy();
      }
   }
}

