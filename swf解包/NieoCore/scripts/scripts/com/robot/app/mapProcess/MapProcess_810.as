package com.robot.app.mapProcess
{
   import com.robot.app.spt.FightBossController;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskscollection.Task1330;
   import com.robot.app.task.taskscollection.Task1343;
   import com.robot.app.task.taskscollection.Task1399;
   import com.robot.core.aimat.AimatController;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.dispatcher.FightDispatcher;
   import com.robot.core.event.AimatEvent;
   import com.robot.core.event.PetFightEvent;
   import com.robot.core.info.fightInfo.attack.FightOverInfo;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import org.taomee.manager.ToolTipManager;
   
   public class MapProcess_810 extends BaseMapProcess
   {
      
      private var sptMC:MovieClip;
      
      private var leafMC:MovieClip;
      
      public function MapProcess_810()
      {
         super();
      }
      
      override protected function init() : void
      {
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         Task1330.initForMap810(this);
         Task1343.initForMap810(this);
         Task1399.initForMap810(this);
         this.sptMC = this.conLevel["boss"];
         ToolTipManager.add(this.sptMC,"用头部射击试试吧！");
         AimatController.addEventListener(AimatEvent.PLAY_END,this.onAimatEndFun);
         this.leafMC = this.conLevel["leaf"];
         this.leafMC.buttonMode = true;
         this.leafMC.addEventListener(MouseEvent.CLICK,this.onLeafClick);
      }
      
      private function onLeafClick(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         this.leafMC.gotoAndStop(1);
         KTool.enableMC([this.leafMC],false);
         AnimateManager.playMcAnimate(this.leafMC,2,"mc2",function():void
         {
            leafMC.gotoAndStop(1);
            KTool.enableMC([leafMC],true);
         });
      }
      
      private function onAimatEndFun(param1:AimatEvent) : void
      {
         var _loc2_:Point = param1.info.endPos;
         if(this.sptMC.hitTestPoint(_loc2_.x,_loc2_.y))
         {
            this.onShowBoss();
         }
      }
      
      private function onShowBoss() : void
      {
         KTool.enableMC([this.sptMC],false);
         AnimateManager.playMcAnimate(this.sptMC,2,"mc2",function():void
         {
            KTool.enableMC([sptMC],true);
            NpcDialog.show(NPC.FUXISI,["我是神树的树灵，你愿意和我一比高低吗？"],["好的，我们切磋下吧","不我还没有准备好！"],[function():void
            {
               SocketConnection.send(1022,83954483);
               FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,onFightFinish);
               FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,onFightFinish);
               FightBossController.fightBoss("弗希斯");
            },function():void
            {
               KTool.enableMC([sptMC],false);
               AnimateManager.playMcAnimate(sptMC,3,"mc3",function():void
               {
                  sptMC.gotoAndStop(1);
                  KTool.enableMC([sptMC],true);
               });
            }]);
         });
      }
      
      private function onFightFinish(param1:PetFightEvent) : void
      {
         FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,this.onFightFinish);
         var _loc2_:FightOverInfo = param1.dataObj as FightOverInfo;
         if(_loc2_.winnerID == MainManager.actorID)
         {
            NpcDialog.show(NPC.FUXISI,["你的实力让我打开眼界，我承认你是一个真正的强者！"],["哈哈，谢谢！"]);
            SocketConnection.send(1022,83954739);
         }
         else
         {
            NpcDialog.show(NPC.FUXISI,["失败并不可怕，可怕的是失去勇气，我等你再次挑战我！"],["我一定会回来再次挑战你的！"]);
            SocketConnection.send(1022,83954995);
         }
      }
      
      override public function destroy() : void
      {
         Task1330.destroy();
         Task1343.destroy();
         Task1399.destroy();
         ToolTipManager.remove(this.sptMC);
         AimatController.removeEventListener(AimatEvent.PLAY_END,this.onAimatEndFun);
         this.leafMC.removeEventListener(MouseEvent.CLICK,this.onLeafClick);
         this.sptMC = null;
         this.leafMC = null;
      }
   }
}

