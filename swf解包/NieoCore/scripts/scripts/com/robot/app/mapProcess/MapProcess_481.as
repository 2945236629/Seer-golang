package com.robot.app.mapProcess
{
   import com.robot.app.fightNote.*;
   import com.robot.app.task.petstory.*;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.mode.*;
   import com.robot.core.utils.*;
   import flash.events.*;
   import flash.geom.*;
   import org.taomee.manager.*;
   
   public class MapProcess_481 extends BaseMapProcess
   {
      
      private var _bossMC:BossModel;
      
      public function MapProcess_481()
      {
         super();
      }
      
      override protected function init() : void
      {
         PetStory_1.initTask(this);
         this.inita();
      }
      
      override public function destroy() : void
      {
         super.destroy();
         this.des();
      }
      
      private function inita() : void
      {
         if(!this._bossMC)
         {
            this._bossMC = new BossModel(597,48);
            this._bossMC.setDirection(Direction.LEFT);
            this._bossMC.show(new Point(460,140),0);
            var _temp_1:* = this._bossMC;
            this._bossMC.scaleY = 2;
            _temp_1.scaleX = 2;
         }
         this._bossMC.mouseEnabled = true;
         this._bossMC.addEventListener(MouseEvent.CLICK,this.onBossClick);
         ToolTipManager.add(this._bossMC,"史密斯");
      }
      
      private function des() : void
      {
         ToolTipManager.remove(this._bossMC);
         this._bossMC.removeEventListener(MouseEvent.CLICK,this.onBossClick);
      }
      
      private function onBossClick(param1:MouseEvent) : void
      {
         FightInviteManager.fightWithBoss("史密斯");
      }
   }
}

