package com.robot.app.mapProcess
{
   import com.robot.app.fightLevel.FightPetBagController;
   import com.robot.app.group.manager.GroupFightInviteManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   public class MapProcess_755 extends BaseMapProcess
   {
      
      private var _monsterMC:SimpleButton;
      
      private var _bossMC:MovieClip;
      
      public function MapProcess_755()
      {
         super();
      }
      
      override protected function init() : void
      {
         this._monsterMC = conLevel["mosterMc"];
         this._monsterMC.addEventListener(MouseEvent.CLICK,this.onHealClick);
         this._bossMC = conLevel["petMC"];
         this._bossMC.buttonMode = true;
         this._bossMC.addEventListener(MouseEvent.CLICK,this.onFightWithBoss);
      }
      
      override public function destroy() : void
      {
         this._monsterMC.removeEventListener(MouseEvent.CLICK,this.onHealClick);
         this._bossMC.removeEventListener(MouseEvent.CLICK,this.onFightWithBoss);
      }
      
      private function onHealClick(param1:MouseEvent) : void
      {
         FightPetBagController.show(true);
      }
      
      private function onFightWithBoss(param1:MouseEvent) : void
      {
         GroupFightInviteManager.fightWithBoss("卡罗特利");
      }
   }
}

