package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.*;
   import com.robot.app.toolBar.*;
   import com.robot.core.config.*;
   import com.robot.core.manager.*;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.events.*;
   
   public class MapProcess_687 extends BaseMapProcess
   {
      
      public function MapProcess_687()
      {
         super();
      }
      
      override protected function init() : void
      {
         topLevel.mouseEnabled = false;
         topLevel.mouseChildren = false;
         this.setVisible();
         conLevel["poster"].buttonMode = true;
         conLevel["poster"].addEventListener(MouseEvent.CLICK,this.onClickPoster);
         Task1143.initFor687(this);
         Task811.initTaskForMap687(this);
      }
      
      private function setVisible() : void
      {
         animatorLevel["task_811_3"].visible = false;
         conLevel["activity"].visible = false;
         conLevel["drag"].visible = false;
         conLevel["blood"].visible = false;
         conLevel["challenge"].visible = false;
         conLevel["vortex"].visible = false;
         conLevel["run"].visible = false;
         conLevel["pk"].visible = false;
      }
      
      override public function destroy() : void
      {
         Task811.destroy();
         ToolBarController.showOrHideAllUser(true);
         if(Boolean(Task1143._isFirst) && !Task1143._isFight)
         {
            Task1143._isFirst = false;
         }
         Task1143.destroy();
      }
      
      private function onClickPoster(param1:MouseEvent) : void
      {
         ModuleManager.showModule(ClientConfig.getAppModule("SeaVortexActivity"),"正在加载...","活动时间：9月11日 - 9月17日\n每天18:00-20:00");
      }
   }
}

