package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TaskController_902;
   import com.robot.app.task.taskscollection.Task902;
   import com.robot.app.task.taskscollection.Task913;
   import com.robot.core.manager.TasksManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NpcController;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class MapProcess_706 extends BaseMapProcess
   {
      
      public function MapProcess_706()
      {
         super();
      }
      
      override protected function init() : void
      {
         this.initCirrus();
         this.initPillars();
         if(TasksManager.getTaskStatus(TaskController_902.TASK_ID) != TasksManager.COMPLETE)
         {
            NpcController.hideNpc(117);
            Task902.initForMap706(this);
            conLevel["task913mc"].visible = false;
         }
         else
         {
            DisplayUtil.removeForParent(conLevel["task902mc"]);
            Task913.initForMap706(this);
         }
      }
      
      private function initCirrus() : void
      {
         (conLevel["cirrus"] as MovieClip).gotoAndStop(1);
      }
      
      private function initPillars() : void
      {
         var i:uint = 1;
         while(i <= 4)
         {
            (conLevel["pillar" + i] as MovieClip).gotoAndStop(1);
            (conLevel["pillar" + i] as MovieClip).buttonMode = true;
            i++;
         }
         if(TasksManager.getTaskStatus(TaskController_902.TASK_ID) == TasksManager.ALR_ACCEPT)
         {
            TasksManager.getProStatusList(TaskController_902.TASK_ID,function(param1:Array):void
            {
               if(!param1[0] || !param1[1])
               {
                  addPillarsEventListener();
               }
            });
         }
         else
         {
            this.addPillarsEventListener();
         }
      }
      
      private function addPillarsEventListener() : void
      {
         var _loc1_:uint = 1;
         while(_loc1_ <= 4)
         {
            (conLevel["pillar" + _loc1_] as MovieClip).addEventListener(MouseEvent.CLICK,this.onPillarClick);
            _loc1_++;
         }
      }
      
      private function onPillarClick(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         _loc2_.removeEventListener(MouseEvent.CLICK,this.onPillarClick);
         _loc2_.addEventListener(Event.ENTER_FRAME,this.onPillarEnterFlame);
         _loc2_.gotoAndPlay(3);
      }
      
      private function onPillarEnterFlame(param1:Event) : void
      {
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         if(_loc2_.currentFrame == _loc2_.totalFrames)
         {
            _loc2_.removeEventListener(Event.ENTER_FRAME,this.onPillarEnterFlame);
            this.updateCirrus();
         }
      }
      
      private function updateCirrus() : void
      {
         var _loc1_:uint = 1;
         while(_loc1_ <= 4)
         {
            if((conLevel["pillar" + _loc1_] as MovieClip).currentFrame < (conLevel["pillar" + _loc1_] as MovieClip).totalFrames)
            {
               return;
            }
            _loc1_++;
         }
         (conLevel["cirrus"] as MovieClip).gotoAndPlay(2);
      }
      
      private function clearPillars() : void
      {
         var _loc1_:uint = 1;
         while(_loc1_ <= 4)
         {
            (conLevel["pillar" + _loc1_] as MovieClip).removeEventListener(MouseEvent.CLICK,this.onPillarClick);
            (conLevel["pillar" + _loc1_] as MovieClip).removeEventListener(Event.ENTER_FRAME,this.onPillarEnterFlame);
            _loc1_++;
         }
      }
      
      override public function destroy() : void
      {
         Task902.destroy();
         Task913.destroy();
         this.clearPillars();
         super.destroy();
      }
   }
}

