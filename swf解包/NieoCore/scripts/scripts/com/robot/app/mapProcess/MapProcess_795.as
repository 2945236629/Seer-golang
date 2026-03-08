package com.robot.app.mapProcess
{
   import com.robot.app.spt.FightBossController;
   import com.robot.app.task.taskscollection.Task1278;
   import com.robot.app.task.taskscollection.Task1281;
   import com.robot.app.task.taskscollection.Task1288;
   import com.robot.app.task.taskscollection.Task1312;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.dispatcher.FightDispatcher;
   import com.robot.core.event.PetFightEvent;
   import com.robot.core.info.fightInfo.attack.FightOverInfo;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class MapProcess_795 extends BaseMapProcess
   {
      
      private var _clickNum:uint = 0;
      
      public function MapProcess_795()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86053247);
         SocketConnection.send(1022,86053248);
         this.initBoss();
         Task1278.initForMap795(this);
         Task1281.initForMap795(this);
         Task1288.initForMap795(this);
         Task1312.initForMap795(this);
      }
      
      private function sptClickAble(param1:Boolean = true) : void
      {
         this.bossMC.buttonMode = param1;
         this.bossMC.mouseChildren = param1;
         this.bossMC.mouseEnabled = param1;
      }
      
      private function initBoss() : void
      {
         MapListenerManager.add(this.bossMC,this.onBossClick,"库里");
      }
      
      private function onBossClick(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         ++this._clickNum;
         switch(this._clickNum)
         {
            case 1:
               AnimateManager.playMcAnimate(this.bossMC,2,"mc2");
               this.sptClickAble(true);
               break;
            case 2:
               AnimateManager.playMcAnimate(this.bossMC,3,"mc3");
               this.sptClickAble(true);
               break;
            case 3:
               this.sptClickAble(false);
               AnimateManager.playMcAnimate(this.bossMC,4,"mc4");
               NpcDialog.show(NPC.KULI,["我是天马族的大长老库里，最喜欢和强者一决高下，你是强者吗！敢跟我比试一下吗?"],["我是强者！我要挑战你！","让我先修炼一下再来挑战你！"],[function():void
               {
                  FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,onFightFinish);
                  FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,onFightFinish);
                  FightBossController.fightBoss("库里");
               },function():void
               {
                  overHandler();
               }]);
         }
      }
      
      private function onFightFinish(param1:PetFightEvent) : void
      {
         var info:FightOverInfo;
         var evt:PetFightEvent = param1;
         FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,this.onFightFinish);
         info = evt.dataObj as FightOverInfo;
         this.bossMC.gotoAndStop(5);
         if(info.winnerID == MainManager.actorID)
         {
            NpcDialog.show(NPC.KULI,["你果然是个名符其实的强者！这一架打的真痛快！哈哈哈哈！"],null,null,false,function():void
            {
               overHandler();
            });
         }
         else
         {
            NpcDialog.show(NPC.KULI,["你已经很强大了，不过还不是我的对手，好好修炼一番再来吧！我等着你！"],null,null,false,function():void
            {
               overHandler();
            });
         }
      }
      
      private function overHandler() : void
      {
         AnimateManager.playMcAnimate(this.bossMC,5,"mc5",function():void
         {
            sptClickAble(true);
            bossMC.gotoAndStop(1);
            _clickNum = 0;
         });
      }
      
      private function get bossMC() : MovieClip
      {
         var _loc1_:MovieClip = MapManager.currentMap.controlLevel["sptBoss"] as MovieClip;
         if(_loc1_ != null)
         {
            return _loc1_;
         }
         return null;
      }
      
      override public function destroy() : void
      {
         Task1278.destroy();
         Task1281.destroy();
         Task1288.destroy();
         Task1312.destroy();
      }
   }
}

