package com.robot.app.mapProcess
{
   import com.robot.app.task.control.*;
   import com.robot.app.task.taskscollection.*;
   import com.robot.core.animate.*;
   import com.robot.core.event.*;
   import com.robot.core.manager.*;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import org.taomee.utils.*;
   
   public class MapProcess_434 extends BaseMapProcess
   {
      
      private static var stoneRemoved:Boolean = false;
      
      public function MapProcess_434()
      {
         super();
      }
      
      override protected function init() : void
      {
         this.topLevel.mouseEnabled = false;
         this.topLevel.mouseChildren = false;
         this.initForAll();
         if(TasksManager.getTaskStatus(TaskController_683.TASK_ID) == TasksManager.ALR_ACCEPT)
         {
            Task683.initTaskForMap434(this);
            return;
         }
         Task687.initTaskForMap434(this);
      }
      
      override public function destroy() : void
      {
         Task683.destroy();
         Task687.destroy();
         this.destroyForAll();
      }
      
      private function initForAll() : void
      {
         if(stoneRemoved)
         {
            this.conLevel["stone1MC"].gotoAndStop(3);
            this.conLevel["stone2MC"].gotoAndStop(3);
            this.conLevel["stone3MC"].gotoAndStop(4);
            this.conLevel["riverMC"].visible = false;
            DisplayUtil.removeForParent(this.typeLevel["mc"]);
            MapManager.currentMap.makeMapArray();
         }
         else
         {
            MainManager.actorModel.addEventListener(RobotEvent.WALK_ENTER_FRAME,this.walkHandler);
         }
      }
      
      private function walkHandler(param1:RobotEvent) : void
      {
         var evt:RobotEvent = param1;
         if(Point.distance(MainManager.actorModel.pos,new Point(238,407)) < 160)
         {
            MainManager.actorModel.removeEventListener(RobotEvent.WALK_ENTER_FRAME,this.walkHandler);
            NpcDialog.show(NPC.SEER,["这里的湖堤裂开了，我们必须先把缺口堵住，才能过去！"],["（点击发亮的石块）"],[function():void
            {
               conLevel["stone1MC"].gotoAndStop(2);
               conLevel["stone2MC"].gotoAndStop(2);
               conLevel["stone3MC"].gotoAndStop(2);
               conLevel["stone1MC"].buttonMode = true;
               conLevel["stone1MC"].addEventListener(MouseEvent.CLICK,stoneClickHandler);
               conLevel["stone2MC"].buttonMode = true;
               conLevel["stone2MC"].addEventListener(MouseEvent.CLICK,stoneClickHandler);
               conLevel["stone3MC"].buttonMode = true;
               conLevel["stone3MC"].addEventListener(MouseEvent.CLICK,stoneClickHandler);
            }]);
         }
      }
      
      private function stoneClickHandler(param1:MouseEvent) : void
      {
         var mc:MovieClip = null;
         var evt:MouseEvent = param1;
         mc = evt.currentTarget as MovieClip;
         mc.gotoAndStop(3);
         mc.buttonMode = false;
         mc.removeEventListener(MouseEvent.CLICK,this.stoneClickHandler);
         if(this.conLevel["stone1MC"].currentFrame == 3 && this.conLevel["stone2MC"].currentFrame == 3 && this.conLevel["stone3MC"].currentFrame == 3)
         {
            AnimateManager.playMcAnimate(this.conLevel["riverMC"],2,"mc2",function():void
            {
               NpcDialog.show(NPC.SEER,["哈哈，终于搞定了，我们赶紧通过这里吧！"],["嗯，前进！"],[function():void
               {
                  stoneRemoved = true;
                  DisplayUtil.removeForParent(typeLevel["mc"]);
                  MapManager.currentMap.makeMapArray();
               }]);
            });
         }
      }
      
      private function destroyForAll() : void
      {
         MainManager.actorModel.removeEventListener(RobotEvent.WALK_ENTER_FRAME,this.walkHandler);
         this.conLevel["stone1MC"].removeEventListener(MouseEvent.CLICK,this.stoneClickHandler);
         this.conLevel["stone2MC"].removeEventListener(MouseEvent.CLICK,this.stoneClickHandler);
         this.conLevel["stone3MC"].removeEventListener(MouseEvent.CLICK,this.stoneClickHandler);
      }
   }
}

