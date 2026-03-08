package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.*;
   import com.robot.app.toolBar.*;
   import com.robot.core.animate.*;
   import com.robot.core.config.*;
   import com.robot.core.manager.*;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_689 extends BaseMapProcess
   {
      
      public function MapProcess_689()
      {
         super();
      }
      
      override protected function init() : void
      {
         var map:BaseMapProcess = null;
         map = null;
         map = this;
         Task812._map = map;
         topLevel.mouseEnabled = false;
         topLevel.mouseChildren = false;
         ToolBarController.showOrHideAllUser(false);
         conLevel["space"].visible = false;
         conLevel["ball0"].visible = false;
         conLevel["ball1"].visible = false;
         conLevel["ball2"].visible = false;
         conLevel["blood0"].visible = true;
         conLevel["blood1"].visible = true;
         conLevel["blood2"].visible = true;
         conLevel["pet0"].visible = false;
         conLevel["pet1"].visible = false;
         conLevel["pet2"].visible = false;
         if(Task812._isFight)
         {
            return;
         }
         if(!BufferRecordManager.getState(MainManager.actorInfo,221))
         {
            AnimateManager.playFullScreenAnimate(ClientConfig.getFullMovie("task_812_1"),function():void
            {
               BufferRecordManager.setState(MainManager.actorInfo,221,true);
               Task812.activityStep(map);
            });
         }
         else
         {
            Task812.activityStep(this);
         }
      }
      
      override public function destroy() : void
      {
         Task812.destroy();
         ToolBarController.showOrHideAllUser(true);
      }
   }
}

