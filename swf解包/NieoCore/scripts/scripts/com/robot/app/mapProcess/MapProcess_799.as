package com.robot.app.mapProcess
{
   import com.robot.app.spt.FightBossController;
   import com.robot.app.task.taskscollection.Task1288;
   import com.robot.app.task.taskscollection.Task1297;
   import com.robot.core.dispatcher.FightDispatcher;
   import com.robot.core.event.PetFightEvent;
   import com.robot.core.info.fightInfo.attack.FightOverInfo;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class MapProcess_799 extends BaseMapProcess
   {
      
      private var diaoMC:MovieClip;
      
      private var diaoBtn:MovieClip;
      
      private var sptMC:MovieClip;
      
      public function MapProcess_799()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86053247);
         SocketConnection.send(1022,86053251);
         Task1288.initForMap799(this);
         Task1297.initForMap799(this);
         this.sptMC = MapManager.currentMap.controlLevel["spt"];
         this.diaoBtn = MapManager.currentMap.controlLevel["task1288Diao"];
         this.diaoMC = MapManager.currentMap.controlLevel["diao"];
         if(Boolean(this.diaoMC) && Boolean(this.diaoBtn) && this.diaoMC.visible)
         {
            this.diaoMC.mouseChildren = false;
            this.diaoMC.mouseEnabled = false;
            this.diaoBtn.buttonMode = true;
            this.diaoBtn.addEventListener(MouseEvent.CLICK,this.onClick);
         }
         if(Boolean(this.sptMC) && this.sptMC.visible)
         {
            this.sptMC.buttonMode = true;
            this.sptMC.addEventListener(MouseEvent.CLICK,this.onBossClick);
         }
      }
      
      private function onBossClick(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         NpcDialog.show(NPC.LUOLASIKE,["我是黑色天马的好朋友洛拉斯克，有没有兴趣跟我比一比高低？"],["好的，我们切磋下吧","不我还没有准备好！"],[function():void
         {
            FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,onFightFinish);
            FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,onFightFinish);
            FightBossController.fightBoss("洛拉斯克");
         }]);
      }
      
      private function onFightFinish(param1:PetFightEvent) : void
      {
         FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,this.onFightFinish);
         var _loc2_:FightOverInfo = param1.dataObj as FightOverInfo;
         if(_loc2_.winnerID == MainManager.actorID)
         {
            NpcDialog.show(NPC.LUOLASIKE,["想不到你竟然有这么强的实力！我就知道你是个了不起的家伙！"],["哈哈，谢谢！"]);
         }
         else
         {
            NpcDialog.show(NPC.LUOLASIKE,["失败是成功的开始！不要灰心！我一直都在这里，随时欢迎你再来挑战我！"],["我一定会回来再次挑战你的！"]);
         }
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         if(this.diaoMC.currentFrame == 1)
         {
            this.diaoMC.gotoAndStop(3);
         }
         else
         {
            this.diaoMC.gotoAndStop(1);
         }
      }
      
      override public function destroy() : void
      {
         Task1288.destroy();
         Task1297.destroy();
         if(Boolean(this.diaoMC) && Boolean(this.diaoBtn))
         {
            this.diaoBtn.removeEventListener(MouseEvent.CLICK,this.onClick);
         }
         if(this.sptMC)
         {
            this.sptMC.removeEventListener(MouseEvent.CLICK,this.onBossClick);
         }
      }
   }
}

