package com.robot.app.mapProcess
{
   import com.robot.app.spt.FightBossController;
   import com.robot.app.task.taskscollection.Task1260;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.dispatcher.FightDispatcher;
   import com.robot.core.event.PetFightEvent;
   import com.robot.core.info.fightInfo.attack.FightOverInfo;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   import com.robot.core.utils.CommonUI;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class MapProcess_789 extends BaseMapProcess
   {
      
      private var _sptClickTimes:uint;
      
      public function MapProcess_789()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86063752);
         MapListenerManager.add(btnLevel["btnMirror"],this.onMirrorClick,"万圣鬼脸糖兑换");
         Task1260.initForMap789(this);
         this.initBoss();
      }
      
      private function onMirrorClick(param1:MouseEvent) : void
      {
         SocketConnection.send(1022,86051425);
         CommonUI.removeYellowArrow(topLevel);
         ModuleManager.showModule(ClientConfig.getAppModule("HalloWeenCandyExchangePanel"));
      }
      
      private function initBoss() : void
      {
         this.bossMC.gotoAndStop(1);
         MapListenerManager.add(this.bossMC,this.onBossClick,"斯图尔特");
      }
      
      private function onBossClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         ++this._sptClickTimes;
         if(this._sptClickTimes <= 4)
         {
            AnimateManager.playMcAnimate(this.bossMC,this._sptClickTimes,"mc" + this._sptClickTimes,function():void
            {
               bossMC.gotoAndStop(_sptClickTimes + 1);
            });
         }
         else
         {
            NpcDialog.show(NPC.SITUERTE,["既然闯入了我镇守的藏宝密室，就拿出你最强的实力和我一战吧"],["让我见识一下你的强大吧！ ","我只是路过而已……"],[function():void
            {
               FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,onFightFinish);
               FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,onFightFinish);
               FightBossController.fightBoss("斯图尔特");
            },function():void
            {
               AnimateManager.playMcAnimate(bossMC,5,"mc5",function():void
               {
                  bossMC.buttonMode = true;
                  bossMC.gotoAndStop(1);
                  _sptClickTimes = 0;
               });
            }]);
         }
      }
      
      private function onFightFinish(param1:PetFightEvent) : void
      {
         var info:FightOverInfo;
         var e:PetFightEvent = param1;
         FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,this.onFightFinish);
         info = e.dataObj as FightOverInfo;
         this.bossMC.gotoAndStop(5);
         if(info.winnerID == MainManager.actorID)
         {
            NpcDialog.show(NPC.SITUERTE,["想不到你的实力如此之强，这密室里的宝藏，就随便你拿吧！"],["哈哈，谢谢！"],[function():void
            {
               AnimateManager.playMcAnimate(bossMC,5,"mc5",function():void
               {
                  bossMC.buttonMode = true;
                  bossMC.gotoAndStop(1);
                  _sptClickTimes = 0;
               });
            }]);
         }
         else
         {
            NpcDialog.show(NPC.SITUERTE,["就这点实力也想在我眼皮下寻宝？去锻炼一下再来吧！我等着你！"],["我一定会回来再次挑战你的！"],[function():void
            {
               AnimateManager.playMcAnimate(bossMC,5,"mc5",function():void
               {
                  bossMC.buttonMode = true;
                  bossMC.gotoAndStop(1);
                  _sptClickTimes = 0;
               });
            }]);
         }
      }
      
      private function get bossMC() : MovieClip
      {
         if(MapManager.currentMap.controlLevel["sptBoss"] != null)
         {
            return MapManager.currentMap.controlLevel["sptBoss"];
         }
         return null;
      }
      
      override public function destroy() : void
      {
         this._sptClickTimes = 0;
      }
   }
}

