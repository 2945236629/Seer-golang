package com.robot.app.mapProcess
{
   import com.robot.app.spt.FightBossController;
   import com.robot.app.task.taskscollection.Task945;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.dispatcher.FightDispatcher;
   import com.robot.core.event.PetFightEvent;
   import com.robot.core.event.RobotEvent;
   import com.robot.core.info.fightInfo.attack.FightOverInfo;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.TasksManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.manager.EventManager;
   import org.taomee.manager.ToolTipManager;
   
   public class MapProcess_710 extends BaseMapProcess
   {
      
      public function MapProcess_710()
      {
         super();
      }
      
      override protected function init() : void
      {
         ToolTipManager.add(conLevel["spt"],"凯洛亚");
         conLevel["water"].mouseChildren = false;
         conLevel["water"].mouseEnabled = false;
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         this.initSptBoss();
         this.initShell();
         Task945.initForMap710(this);
      }
      
      private function initShell() : void
      {
         if(TasksManager.getTaskStatus(945) == TasksManager.ALR_ACCEPT)
         {
            TasksManager.getProStatusList(945,function(param1:Array):void
            {
               if(Boolean(param1[0]) && !param1[1])
               {
                  (animatorLevel["shell"] as MovieClip).gotoAndStop(1);
               }
               else
               {
                  (animatorLevel["shell"] as MovieClip).gotoAndStop(2);
               }
            });
         }
         else
         {
            (animatorLevel["shell"] as MovieClip).gotoAndStop(2);
         }
      }
      
      private function initSptBoss() : void
      {
         (conLevel["spt"] as MovieClip).buttonMode = true;
         (conLevel["spt"] as MovieClip).gotoAndStop(1);
         (conLevel["spt"] as MovieClip).addEventListener(MouseEvent.CLICK,this.onSptClick);
      }
      
      private function onSptClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         (conLevel["spt"] as MovieClip).removeEventListener(MouseEvent.CLICK,this.onSptClick);
         AnimateManager.playMcAnimate(conLevel["spt"],2,"mc",function():void
         {
            NpcDialog.show(NPC.KAILUOYA,["没有谁能从我掌管的这片水域通过，不管是谁都将被这片海水吞没，不行你可以试试！"],["我现在就挑战你！","让我再考虑一下！"],[function():void
            {
               FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,onFightOver);
               EventManager.removeEventListener(RobotEvent.NO_PET_CAN_FIGHT,onStartFail);
               FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,onFightOver);
               EventManager.addEventListener(RobotEvent.NO_PET_CAN_FIGHT,onStartFail);
               FightBossController.fightBoss("凯洛亚");
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
            NpcDialog.show(NPC.KAILUOYA,["小子，我早就说过，没有谁能够通过这片水域，再好好练练吧！"],["下次我一定会战胜你的！"],[this.resetSpt]);
         }
         else
         {
            NpcDialog.show(NPC.KAILUOYA,["小子，你叫什么名字，尽然有如此强大的实力，最为对手我尊敬你！"],["哈哈！我的实力可是深不可测的哦！"],[null]);
         }
      }
      
      private function resetSpt() : void
      {
         AnimateManager.playMcAnimate(conLevel["spt"],3,"mc",function():void
         {
            initSptBoss();
         });
      }
      
      override public function destroy() : void
      {
         ToolTipManager.remove(conLevel["spt"]);
         FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,this.onFightOver);
         EventManager.removeEventListener(RobotEvent.NO_PET_CAN_FIGHT,this.onStartFail);
         Task945.destroy();
         conLevel["spt"].removeEventListener(MouseEvent.CLICK,this.onSptClick);
         super.destroy();
      }
   }
}

