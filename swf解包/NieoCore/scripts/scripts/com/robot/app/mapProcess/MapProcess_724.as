package com.robot.app.mapProcess
{
   import com.robot.app.control.SPTSleepEvoController;
   import com.robot.app.spt.FightBossController;
   import com.robot.app.task.taskscollection.Task999;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.dispatcher.FightDispatcher;
   import com.robot.core.event.PetFightEvent;
   import com.robot.core.event.RobotEvent;
   import com.robot.core.info.fightInfo.attack.FightOverInfo;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.manager.EventManager;
   
   public class MapProcess_724 extends BaseMapProcess
   {
      
      public function MapProcess_724()
      {
         super();
      }
      
      override protected function init() : void
      {
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         this.initBoss();
         Task999.initTaskForMap724(this);
         SPTSleepEvoController.setup(this);
      }
      
      private function initBoss() : void
      {
         this.sptBossMc.buttonMode = true;
         this.sptBossMc.addEventListener(MouseEvent.CLICK,this.showBoss);
      }
      
      private function showBoss(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         SPTSleepEvoController.hideArrow();
         NpcDialog.show(NPC.SILIPU,["这里是上古龙殿，我是这里的守护者斯利普，想尝尝上古的力量吗？那就进入我的梦乡吧！"],["我想挑战你！","我只是来参观的！"],[function():void
         {
            FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,onAlarmClickHandler);
            EventManager.removeEventListener(RobotEvent.NO_PET_CAN_FIGHT,onFightError);
            FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,onAlarmClickHandler);
            EventManager.addEventListener(RobotEvent.NO_PET_CAN_FIGHT,onFightError);
            FightBossController.fightBoss("斯利普");
         }]);
      }
      
      private function onAlarmClickHandler(param1:PetFightEvent) : void
      {
         var e:PetFightEvent = param1;
         FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,this.onAlarmClickHandler);
         EventManager.removeEventListener(RobotEvent.NO_PET_CAN_FIGHT,this.onFightError);
         if((e.dataObj as FightOverInfo).winnerID == MainManager.actorID)
         {
            NpcDialog.show(NPC.SILIPU,["小子，你果然实力非凡，我打从心底里认可你，加油哦！有时间多来这里看看我吧！我一个人挺寂寞的！"],["呵呵，知道啦！"],[function():void
            {
            }]);
         }
         else
         {
            MapManager.currentMap.controlLevel["sptBoss"].gotoAndStop(2);
            NpcDialog.show(NPC.SILIPU,["你的实力还有待提升，继续加油吧！什么时候你能战胜我，那我就告诉你我背后的故事，上古龙族的故事！"],["哼，下次我一定会成功的！"],[function():void
            {
            }]);
         }
      }
      
      private function onFightError(param1:RobotEvent) : void
      {
         var e:RobotEvent = param1;
         FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,this.onAlarmClickHandler);
         EventManager.removeEventListener(RobotEvent.NO_PET_CAN_FIGHT,this.onFightError);
         AnimateManager.playMcAnimate(this.sptBossMc,2,"mc",function():void
         {
            sptBossMc.gotoAndStop(1);
         });
      }
      
      private function get sptBossMc() : MovieClip
      {
         return conLevel["sptBoss"];
      }
      
      override public function destroy() : void
      {
         FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,this.onAlarmClickHandler);
         EventManager.removeEventListener(RobotEvent.NO_PET_CAN_FIGHT,this.onFightError);
         this.sptBossMc.removeEventListener(MouseEvent.CLICK,this.showBoss);
         Task999.destroy();
         SPTSleepEvoController.destroy();
         super.destroy();
      }
   }
}

