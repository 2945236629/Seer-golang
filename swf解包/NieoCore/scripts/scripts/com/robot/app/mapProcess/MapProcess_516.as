package com.robot.app.mapProcess
{
   import com.robot.app.fightNote.*;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.mode.*;
   import com.robot.core.npc.*;
   import com.robot.core.utils.*;
   import flash.events.*;
   import flash.geom.*;
   import org.taomee.manager.*;
   
   public class MapProcess_516 extends BaseMapProcess
   {
      
      private static var _map:BaseMapProcess;
      
      private var _bossMC:BossModel;
      
      public function MapProcess_516()
      {
         super();
         _map = this;
         var _loc1_:int = 0;
         while(_loc1_ < conLevel.numChildren)
         {
            conLevel.getChildAt(_loc1_).visible = false;
            _loc1_++;
         }
         this.inita();
      }
      
      override protected function init() : void
      {
      }
      
      override public function destroy() : void
      {
      }
      
      private function inita() : void
      {
         if(!this._bossMC)
         {
            this._bossMC = new BossModel(261,48);
            this._bossMC.setDirection(Direction.DOWN);
            this._bossMC.show(new Point(480,210),0);
            var _temp_1:* = this._bossMC;
            this._bossMC.scaleY = 2;
            _temp_1.scaleX = 2;
         }
         this._bossMC.mouseEnabled = true;
         this._bossMC.addEventListener(MouseEvent.CLICK,this.onBossClick);
         ToolTipManager.add(this._bossMC,"派送");
      }
      
      private function des() : void
      {
         ToolTipManager.remove(this._bossMC);
         this._bossMC.removeEventListener(MouseEvent.CLICK,this.onBossClick);
      }
      
      private function onBossClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         NpcDialog.show(NPC.LEIYI,["10.1日晚上8点以后和我对战可以每10分钟【0-9,10-19，20-29,30-49,50-59】可领取奖励哦"],["来吧","算了，我再看看"],[function():void
         {
            FightInviteManager.fightWithBoss("派送");
         },function():void
         {
            NpcDialog.show(NPC.LEIYI,["探索一下附近可能也有奇妙奖励哦（似乎和射击有关）"],["我来找找"],null);
         }]);
      }
   }
}

