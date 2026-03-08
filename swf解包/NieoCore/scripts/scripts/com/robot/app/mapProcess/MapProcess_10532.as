package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_3013;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.TasksManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_10532 extends BaseMapProcess
   {
      
      public function MapProcess_10532()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         this.setEnabledShowPanelMC(false);
         TasksManager.getProStatusList(3013,function(param1:Array):void
         {
            if(Boolean(param1[0]) && !param1[1])
            {
               TaskController_3013.pro2();
            }
            else if(Boolean(param1[1]) && !param1[2])
            {
               setEnabledShowPanelMC(true);
            }
         });
      }
      
      public function openPuzzle() : void
      {
         TaskController_3013.openPuzzlePanel(true,function():void
         {
            setEnabledShowPanelMC(false);
         });
      }
      
      public function setEnabledShowPanelMC(param1:Boolean) : void
      {
         MapManager.currentMap.controlLevel["hitPanel"].visible = param1;
         MapManager.currentMap.controlLevel["panelMC"].visible = param1;
         MapManager.currentMap.controlLevel["guide_mc"].visible = param1;
      }
   }
}

