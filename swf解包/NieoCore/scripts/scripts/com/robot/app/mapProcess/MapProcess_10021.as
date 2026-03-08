package com.robot.app.mapProcess
{
   import com.robot.app.freshFightLevel.FightLevelModel;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.utils.CommonUI;
   import com.robot.core.utils.RectangleMask;
   import org.taomee.events.DynamicEvent;
   
   public class MapProcess_10021 extends BaseMapProcess
   {
      
      public function MapProcess_10021()
      {
         super();
      }
      
      override protected function init() : void
      {
      }
      
      override public function destroy() : void
      {
      }
      
      public function trialsFunc() : void
      {
         CommonUI.removeYellowArrow(topLevel);
         FightLevelModel.setUp();
         RectangleMask.dispatchEvent(new DynamicEvent(RectangleMask.CLICK_NEXT,210));
      }
   }
}

