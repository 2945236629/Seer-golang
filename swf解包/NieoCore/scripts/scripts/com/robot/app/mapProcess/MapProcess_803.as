package com.robot.app.mapProcess
{
   import com.robot.app.spt.FightBossController;
   import com.robot.app.task.taskscollection.Task1306;
   import com.robot.core.dispatcher.FightDispatcher;
   import com.robot.core.event.PetFightEvent;
   import com.robot.core.info.fightInfo.attack.FightOverInfo;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.TasksManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class MapProcess_803 extends BaseMapProcess
   {
      
      private var sptMC:MovieClip;
      
      public function MapProcess_803()
      {
         super();
      }
      
      override protected function init() : void
      {
         Task1306.initForMap803(this);
         this.sptMC = MapManager.currentMap.controlLevel["spt"];
         var _loc1_:uint = uint(TasksManager.getTaskStatus(1306));
         if(_loc1_ == TasksManager.ALR_ACCEPT)
         {
            this.sptMC.visible = false;
         }
         else
         {
            this.sptMC.buttonMode = true;
            this.sptMC.addEventListener(MouseEvent.CLICK,this.onBossClick);
         }
      }
      
      private function onBossClick(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         NpcDialog.show(NPC.YISUOLI,["我是盖亚的指引者伊索里，有没有兴趣跟我比一比高低？"],["好的，我们切磋下吧","不我还没有准备好！"],[function():void
         {
            FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,onFightFinish);
            FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,onFightFinish);
            FightBossController.fightBoss("伊索里");
         }]);
      }
      
      private function onFightFinish(param1:PetFightEvent) : void
      {
         FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,this.onFightFinish);
         var _loc2_:FightOverInfo = param1.dataObj as FightOverInfo;
         if(_loc2_.winnerID == MainManager.actorID)
         {
            NpcDialog.show(NPC.YISUOLI,["想不到你竟然有这么强的实力！我就知道你是个了不起的家伙！"],["哈哈，谢谢！"]);
         }
         else
         {
            NpcDialog.show(NPC.YISUOLI,["失败是成功的开始！不要灰心！我一直都在这里，随时欢迎你再来挑战我！"],["我一定会回来再次挑战你的！"]);
         }
      }
      
      override public function destroy() : void
      {
         Task1306.destroy();
         if(this.sptMC.visible)
         {
            this.sptMC.removeEventListener(MouseEvent.CLICK,this.onBossClick);
         }
      }
   }
}

