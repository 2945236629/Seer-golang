package com.robot.app.mapProcess
{
   import com.robot.app.fight.FightManager;
   import com.robot.app.task.taskscollection.Task1063;
   import com.robot.app.task.taskscollection.Task1221;
   import com.robot.app.task.taskscollection.Task1249;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   import flash.events.MouseEvent;
   
   public class MapProcess_730 extends BaseMapProcess
   {
      
      public function MapProcess_730()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86064199);
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         Task1063.initTaskForMap730(this);
         Task1221.initForMap730(this);
         Task1249.initForMap730(this);
      }
      
      protected function onClickDragon(param1:MouseEvent) : void
      {
         SocketConnection.send(1022,86064205);
         ModuleManager.showModule(ClientConfig.getAppModule("AncientDragonPanel"));
      }
      
      protected function onClickNuodi(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         SocketConnection.send(1022,86064209);
         NpcDialog.show(NPC.NUODI,["只能全部唤醒我三种形态，我才能够使魔枭苏醒！你足够强大吗？"],["让我试试！","我本来就不够强大！"],[function():void
         {
            FightManager.fightWithBoss("三形态诺迪",3);
         }]);
      }
      
      override public function destroy() : void
      {
         Task1063.destroy();
         Task1221.destroy();
         Task1249.destroy();
      }
   }
}

