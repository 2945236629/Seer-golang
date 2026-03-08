package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_3015;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.TasksManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_10535 extends BaseMapProcess
   {
      
      public function MapProcess_10535()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         TasksManager.getProStatusList(3015,function(param1:Array):void
         {
            if(Boolean(param1[0]) && !param1[1])
            {
               TaskController_3015.pro2();
            }
            else if(Boolean(param1[1]) && !param1[2])
            {
               setEnabledShowPanelMC(true);
            }
         });
      }
      
      public function openPuzzle() : void
      {
      }
      
      public function setEnabledShowPanelMC(param1:Boolean) : void
      {
         MapManager.currentMap.controlLevel["hitPanel"].visible = param1;
         MapManager.currentMap.controlLevel["panelMC"].visible = param1;
         MapManager.currentMap.controlLevel["guide_mc"].visible = param1;
      }
   }
}

