package com.robot.app.mapProcess
{
   import com.robot.app.fight.*;
   import com.robot.app.fightNote.FightInviteManager;
   import com.robot.core.config.*;
   import com.robot.core.manager.*;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.*;
   import com.robot.core.npc.*;
   import flash.events.*;
   
   public class MapProcess_445 extends BaseMapProcess
   {
      
      public function MapProcess_445()
      {
         super();
      }
      
      override protected function init() : void
      {
         conLevel["kazi2MC"].visible = false;
         conLevel["kaziMC"].visible = false;
         conLevel["black1MC"].visible = false;
         conLevel["black2MC"].visible = false;
         conLevel["kaxiusiMC"].buttonMode = true;
         conLevel["kaxiusiMC"].addEventListener(MouseEvent.CLICK,this.kaxiusiClickHandler);
      }
      
      private function kaxiusiClickHandler(param1:MouseEvent) : void
      {
         NpcDialog.show(NPC.KAXIUSI_WHITE,["守护炫彩山是我的使命！"],["我要挑战你！","嗯，你好好站岗吧，我顶你！"],[function():void
         {
            FightInviteManager.fightWithBoss("卡修斯",0,true);
         },function():void
         {
         }]);
      }
      
      override public function destroy() : void
      {
      }
      
      public function gotoHoleFight() : void
      {
         SocketConnection.send(1022,86053859);
         ModuleManager.showModule(ClientConfig.getAppModule("HolePanel"),"炫彩山山洞入口面板");
      }
   }
}

