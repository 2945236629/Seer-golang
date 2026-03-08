package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.*;
   import com.robot.app.toolBar.*;
   import com.robot.core.aimat.*;
   import com.robot.core.animate.*;
   import com.robot.core.event.*;
   import com.robot.core.manager.*;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.utils.*;
   import flash.geom.Point;
   import org.taomee.manager.*;
   import org.taomee.utils.*;
   
   public class MapProcess_685 extends BaseMapProcess
   {
      
      public function MapProcess_685()
      {
         super();
      }
      
      override protected function init() : void
      {
         var map:BaseMapProcess = null;
         map = null;
         map = this;
         animatorLevel["task_811_5"].visible = false;
         animatorLevel["task_801_2"].visible = false;
         animatorLevel["task_796_2"].visible = false;
         this.initIceBridge();
         Task811.initTaskForMap685(this);
         TasksManager.getProStatusList(811,function(param1:Array):void
         {
            var a:Array = param1;
            if(Boolean(a[0]) && Boolean(a[1]) && Boolean(a[2]) && Boolean(a[3]) && !a[4])
            {
               return;
            }
            Task801.initTaskForMap685(map);
            TasksManager.getProStatusList(801,function(param1:Array):void
            {
               if(param1[0] && param1[1] && !param1[2] || !param1[0])
               {
                  return;
               }
               Task796.initTaskForMap685(map);
            });
            if(TasksManager.getTaskStatus(801) == TasksManager.ALR_ACCEPT)
            {
               TasksManager.getProStatusList(801,function(param1:Array):void
               {
                  if(!param1[0])
                  {
                     Task796.initTaskForMap685(map);
                  }
               });
            }
         });
      }
      
      private function initIceBridge() : void
      {
         ToolTipManager.add(conLevel["iceBridge"],"冰锥");
         AimatController.addEventListener(AimatEvent.PLAY_END,this.onShootIce);
      }
      
      public function onShootIce(param1:AimatEvent) : void
      {
         var point:Point = null;
         var event:AimatEvent = param1;
         if(event.info.userID != MainManager.actorID)
         {
            return;
         }
         point = event.info.endPos;
         if(Boolean(conLevel["iceBridge"].hitTestPoint(point.x,point.y)))
         {
            ToolTipManager.remove(conLevel["iceBridge"]);
            AimatController.removeEventListener(AimatEvent.PLAY_END,this.onShootIce);
            CommonUI.removeYellowArrow(conLevel["iceBridge"]);
            AnimateManager.playMcAnimate(conLevel["iceBridge"],1,"",function():void
            {
               DisplayUtil.removeForParent(typeLevel["barrier"]);
               MapManager.currentMap.makeMapArray();
               if(TasksManager.getTaskStatus(796) == TasksManager.ALR_ACCEPT)
               {
                  TasksManager.getProStatusList(796,function(param1:Array):void
                  {
                     if(Boolean(param1[0]) && Boolean(param1[1]) && !param1[2])
                     {
                        Task796.onShootIceOver();
                     }
                  });
               }
            });
         }
      }
      
      override public function destroy() : void
      {
         Task796.destroy();
         Task801.destroy();
         Task811.destroy();
         if(Boolean(conLevel["iceBridge"]))
         {
            ToolTipManager.remove(conLevel["iceBridge"]);
         }
         AimatController.removeEventListener(AimatEvent.PLAY_END,this.onShootIce);
         ToolBarController.showOrHideAllUser(true);
      }
   }
}

