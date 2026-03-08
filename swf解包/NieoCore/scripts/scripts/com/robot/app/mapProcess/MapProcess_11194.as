package com.robot.app.mapProcess
{
   import com.robot.app.fight.FightManager;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.dispatcher.FightDispatcher;
   import com.robot.core.event.PetFightEvent;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   import flash.events.MouseEvent;
   
   public class MapProcess_11194 extends BaseMapProcess
   {
      
      public function MapProcess_11194()
      {
         super();
      }
      
      override protected function init() : void
      {
         KTool.getMultiValue([2774,12442],function(param1:Array):void
         {
            conLevel["boss"].visible = param1[0] == 2 && KTool.getBit(param1[1],3) == 0;
            conLevel["boss"].addEventListener(MouseEvent.CLICK,npcClick);
         });
      }
      
      private function npcClick(param1:MouseEvent) : void
      {
         NpcDialog.show(NPC.GERLUTER,["想要挑战洛亚之灵，必须先通过我的考验。如果你能击败我，将会获得两次挑战洛亚之灵的机会，但我次日才会再次出现！"],["得罪了，守护者！","看我用钻石砸晕你！","我需要再磨砺一下。"],[this.fight,this.diamond,null]);
      }
      
      private function fight() : void
      {
         FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,function(param1:PetFightEvent):void
         {
            FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,arguments.callee);
            if(param1.dataObj.winnerID == MainManager.actorInfo.userID)
            {
               ModuleManager.showAppModule("MysteryofthewizardKingLevel3MainPanel");
            }
         });
         FightManager.fightNoMapBoss("格鲁特",6785);
      }
      
      private function diamond() : void
      {
         KTool.buyProductByCallback(247179,1,function():void
         {
            SocketConnection.sendByQueue(47284,[2,3],function():void
            {
               conLevel["boss"].visible = false;
               ModuleManager.showAppModule("MysteryofthewizardKingLevel3MainPanel");
            });
         });
      }
      
      override public function destroy() : void
      {
         conLevel["boss"].removeEventListener(MouseEvent.CLICK,this.npcClick);
         super.destroy();
      }
   }
}

