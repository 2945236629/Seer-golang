package com.robot.app.mapProcess
{
   import com.robot.app.spt.FightBossController;
   import com.robot.app.task.control.TaskController_913;
   import com.robot.app.task.taskscollection.Task1721;
   import com.robot.app.task.taskscollection.Task913;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.dispatcher.FightDispatcher;
   import com.robot.core.event.PetFightEvent;
   import com.robot.core.event.RobotEvent;
   import com.robot.core.info.fightInfo.attack.FightOverInfo;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.TasksManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.manager.EventManager;
   import org.taomee.utils.DisplayUtil;
   
   public class MapProcess_708 extends BaseMapProcess
   {
      
      public function MapProcess_708()
      {
         super();
      }
      
      override protected function init() : void
      {
         topLevel.mouseChildren = false;
         if(TasksManager.getTaskStatus(Task1721.TASK_ID) != TasksManager.COMPLETE)
         {
            this.hideSpt();
         }
         else
         {
            this.initSptBoss();
            if(TasksManager.getTaskStatus(TaskController_913.TASK_ID) == TasksManager.UN_ACCEPT || TasksManager.getTaskStatus(TaskController_913.TASK_ID) == TasksManager.ALR_ACCEPT)
            {
               animatorLevel["pathMc"].gotoAndStop(1);
            }
            else
            {
               animatorLevel["pathMc"].gotoAndPlay(2);
               this.openPath();
            }
            Task913.initForMap708(this);
         }
         Task1721.initTaskForMap708(this);
      }
      
      private function hideSpt() : void
      {
         conLevel["spt"].visible = false;
         conLevel["task913mc"].visible = false;
      }
      
      private function openPath() : void
      {
         if(typeLevel["pathMc"])
         {
            DisplayUtil.removeForParent(typeLevel["pathMc"]);
            MapManager.currentMap.makeMapArray();
         }
      }
      
      private function initSptBoss() : void
      {
         (conLevel["spt"] as MovieClip).buttonMode = true;
         (conLevel["spt"] as MovieClip).gotoAndStop(2);
         (conLevel["spt"] as MovieClip).addEventListener(MouseEvent.CLICK,this.onSptClick);
      }
      
      private function onSptClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         (conLevel["spt"] as MovieClip).removeEventListener(MouseEvent.CLICK,this.onSptClick);
         AnimateManager.playMcAnimate(conLevel["spt"],3,"mc",function():void
         {
            NpcDialog.show(NPC.KAWOER,["我是黑风崖的守护精灵，如果你想挑战阿洛比斯就必须战胜我，否则你肯定不是它的对手！开始你的攻击吧！"],["恩，我这就挑战你！","我等会儿再来！"],[function():void
            {
               FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,onFightOver);
               EventManager.addEventListener(RobotEvent.NO_PET_CAN_FIGHT,onStartFail);
               FightBossController.fightBoss("卡沃尔");
            },resetSpt]);
         });
      }
      
      private function onStartFail(param1:RobotEvent) : void
      {
         FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,this.onFightOver);
         EventManager.removeEventListener(RobotEvent.NO_PET_CAN_FIGHT,this.onStartFail);
         this.resetSpt();
      }
      
      private function onFightOver(param1:PetFightEvent) : void
      {
         FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,this.onFightOver);
         EventManager.removeEventListener(RobotEvent.NO_PET_CAN_FIGHT,this.onStartFail);
         var _loc2_:FightOverInfo = param1.dataObj as FightOverInfo;
         if(_loc2_.winnerID != MainManager.actorID)
         {
            NpcDialog.show(NPC.KAWOER,["不行啊！以你目前的状态连我都战胜不了，你如何面对阿洛比斯这个强大的对手呢！还是在继续修炼吧！"],["我是不会放弃的！不久后我一定可以战胜你还有阿洛比斯！"],[this.resetSpt]);
         }
         else
         {
            NpcDialog.show(NPC.KAWOER,["你的实力已经完全超越了我，看来巨石星这次真的有救了！哈哈哈！"],["放心，我一定会击败阿洛比斯的！"],[null]);
         }
      }
      
      private function resetSpt() : void
      {
         AnimateManager.playMcAnimate(conLevel["spt"],4,"mc",function():void
         {
            initSptBoss();
         });
      }
      
      override public function destroy() : void
      {
         (conLevel["spt"] as MovieClip).removeEventListener(MouseEvent.CLICK,this.onSptClick);
         FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,this.onFightOver);
         EventManager.removeEventListener(RobotEvent.NO_PET_CAN_FIGHT,this.onStartFail);
         Task913.destroy();
         super.destroy();
      }
   }
}

