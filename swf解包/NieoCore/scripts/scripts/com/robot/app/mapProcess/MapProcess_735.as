package com.robot.app.mapProcess
{
   import com.robot.app.control.GameStartController;
   import com.robot.app.games.GameStorageManager;
   import com.robot.app.spt.FightBossController;
   import com.robot.app.task.taskscollection.Task1081;
   import com.robot.app.task.taskscollection.Task1203;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.dispatcher.FightDispatcher;
   import com.robot.core.event.PetFightEvent;
   import com.robot.core.info.fightInfo.attack.FightOverInfo;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import org.taomee.manager.ToolTipManager;
   
   public class MapProcess_735 extends BaseMapProcess
   {
      
      private var _task1081HookMC:MovieClip = null;
      
      private var _task1081BossMC:MovieClip = null;
      
      public function MapProcess_735()
      {
         super();
      }
      
      override protected function init() : void
      {
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         this.bossMC.mouseChildren = false;
         this.bossMC.buttonMode = true;
         this.gameMC.mouseChildren = false;
         this.gameMC.buttonMode = true;
         ToolTipManager.add(this.gameMC,"机械精灵连连看");
         ToolTipManager.add(this.bossMC,"博卡特");
         if(this.task1081MC != null)
         {
            this.task1081MC.addEventListener(Event.ENTER_FRAME,this.onFrameHandler);
            this.task1081MC.gotoAndStop(1);
         }
         this.bossMC.addEventListener(MouseEvent.CLICK,this.onBossClick);
         this.gameMC.addEventListener(MouseEvent.CLICK,this.onGameCLK);
         Task1203.initForMap735(this);
      }
      
      private function onFrameHandler(param1:Event) : void
      {
         this.task1081MC.removeEventListener(Event.ENTER_FRAME,this.onFrameHandler);
         if(this.task1081MC["mc"]["task1081HookMC"] != null)
         {
            this._task1081HookMC = this.task1081MC["mc"]["task1081HookMC"];
         }
         if(this.task1081MC["mc"]["task1081BossMC"] != null)
         {
            this._task1081BossMC = this.task1081MC["mc"]["task1081BossMC"];
         }
         Task1081.initTaskForMap735(this);
         this.bossMC.gotoAndStop(1);
      }
      
      private function onBossClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         this.bossMC.buttonMode = false;
         if(this._task1081HookMC != null)
         {
            this._task1081HookMC.visible = false;
         }
         if(this._task1081BossMC != null)
         {
            this._task1081BossMC.visible = false;
         }
         AnimateManager.playMcAnimate(this.bossMC,2,"mc",function():void
         {
            fightWithBoss();
         });
      }
      
      private function fightWithBoss() : void
      {
         NpcDialog.show(NPC.BOKATE,["给我站住，这里可是海盗集团最机密的研究所，不自量力的家伙，遇到我算你倒霉！！"],["哼，我正想挑战你呢！","慢着，让我先准备一下！"],[function():void
         {
            FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,onFightFinish);
            FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,onFightFinish);
            FightBossController.fightBoss("博卡特");
         },function():void
         {
            AnimateManager.playMcAnimate(bossMC,3,"mc",function():void
            {
               bossMC.gotoAndStop(1);
               bossMC.buttonMode = true;
               if(_task1081HookMC != null)
               {
                  _task1081HookMC.visible = true;
               }
               if(_task1081BossMC != null)
               {
                  _task1081BossMC.visible = true;
               }
            });
         }]);
      }
      
      private function onFightFinish(param1:PetFightEvent) : void
      {
         var info:FightOverInfo;
         var e:PetFightEvent = param1;
         FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,this.onFightFinish);
         info = e.dataObj as FightOverInfo;
         if(info.winnerID == MainManager.actorID)
         {
            NpcDialog.show(NPC.BOKATE,["什么！我居然会败给你这小子，你…的实力简直太惊人了！"],["哈哈，知道厉害了吧！"]);
         }
         else
         {
            NpcDialog.show(NPC.BOKATE,["哼哼！你还是回去做个乖宝宝吧！这里不是你该来的地方，快点离开这里！"],["可恶，我还会再来的！"]);
         }
         this.bossMC.gotoAndStop(3);
         AnimateManager.playMcAnimate(this.bossMC,3,"mc",function():void
         {
            bossMC.buttonMode = true;
            bossMC.gotoAndPlay(1);
            if(_task1081HookMC != null)
            {
               _task1081HookMC.visible = true;
               _task1081HookMC.gotoAndPlay(1);
            }
            if(_task1081BossMC != null)
            {
               _task1081BossMC.visible = true;
            }
         });
      }
      
      private function onGameCLK(param1:MouseEvent) : void
      {
         MapManager.removeAppArrow();
         GameStorageManager.freshLastGame(41013);
         GameStartController.show("PetLLKStart","PetLLKGame");
      }
      
      private function get task1081MC() : MovieClip
      {
         if(conLevel["task1081MC"])
         {
            return conLevel["task1081MC"];
         }
         return null;
      }
      
      private function get bossMC() : MovieClip
      {
         return conLevel["bossMC"];
      }
      
      private function get gameMC() : MovieClip
      {
         return conLevel["gameMC"];
      }
      
      override public function destroy() : void
      {
         ToolTipManager.remove(this.bossMC);
         ToolTipManager.remove(this.gameMC);
         this.bossMC.removeEventListener(MouseEvent.CLICK,this.onBossClick);
         this.gameMC.removeEventListener(MouseEvent.CLICK,this.onGameCLK);
         this.task1081MC.removeEventListener(Event.ENTER_FRAME,this.onFrameHandler);
         Task1081.destroy();
         Task1203.destroy();
      }
   }
}

