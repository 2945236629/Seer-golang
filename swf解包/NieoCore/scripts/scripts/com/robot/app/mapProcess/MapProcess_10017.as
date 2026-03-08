package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.events.MouseEvent;
   
   public class MapProcess_10017 extends BaseMapProcess
   {
      
      public function MapProcess_10017()
      {
         super();
      }
      
      override protected function init() : void
      {
         MapListenerManager.add(topLevel["leixiaoyi"],function(param1:MouseEvent):void
         {
            ModuleManager.showModule(ClientConfig.getAppModule("NewSeerTaskPanel_2014"));
         },"试炼之路");
         conLevel["expMachine"].visible = false;
         KTool.getMultiValue([3140],function(param1:Array):void
         {
            if(param1[0] > 21)
            {
               conLevel["expMachine"].visible = true;
            }
         });
         MapListenerManager.add(conLevel["expMachine"],function(param1:MouseEvent):void
         {
            ModuleManager.showModule(ClientConfig.getAppModule("ExpAdmPanel"));
         },"经验分配");
      }
      
      override public function destroy() : void
      {
      }
   }
}

