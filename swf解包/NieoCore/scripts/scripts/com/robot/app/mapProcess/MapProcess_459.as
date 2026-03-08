package com.robot.app.mapProcess
{
   import com.robot.app.mapProcess.control.*;
   import com.robot.app.task.taskscollection.*;
   import com.robot.core.manager.*;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.display.MovieClip;
   import flash.events.*;
   import org.taomee.manager.*;
   
   public class MapProcess_459 extends BaseMapProcess
   {
      
      private static var xuanMc:MovieClip;
      
      public function MapProcess_459()
      {
         super();
      }
      
      private static function onClickXuanHandler(param1:MouseEvent) : void
      {
         MapManager.changeMap(460);
      }
      
      override protected function init() : void
      {
         Task558.initTask_459(this);
         Task560.initTask_459(this);
         Task561.initTask_459(this);
         if(TasksManager.getTaskStatus(560) != TasksManager.ALR_ACCEPT && TasksManager.getTaskStatus(561) != TasksManager.ALR_ACCEPT)
         {
            xuanMc = this.conLevel["xuanMc"];
            ToolTipManager.add(xuanMc,"赫鲁卡星");
            xuanMc.buttonMode = true;
            xuanMc.addEventListener(MouseEvent.CLICK,onClickXuanHandler);
         }
         BaoZhaoMouseSptController.instance.start();
      }
      
      override public function destroy() : void
      {
         if(Boolean(xuanMc))
         {
            ToolTipManager.remove(xuanMc);
            xuanMc.removeEventListener(MouseEvent.CLICK,onClickXuanHandler);
         }
         Task558.destory();
         Task560.destory();
         Task561.destory();
      }
   }
}

