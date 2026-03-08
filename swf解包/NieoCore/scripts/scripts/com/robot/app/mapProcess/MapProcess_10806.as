package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.BitBuffSetClass;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NpcDialog;
   import flash.events.MouseEvent;
   
   public class MapProcess_10806 extends BaseMapProcess
   {
      
      private var _num:uint;
      
      public function MapProcess_10806()
      {
         super();
      }
      
      override protected function init() : void
      {
         conLevel["mc_mov"].visible = false;
         conLevel["mc_npc"].visible = false;
         if(BitBuffSetClass.getState(22636))
         {
            this.initNpc();
         }
         else
         {
            BitBuffSetClass.setState(22636,1);
            KTool.hideMapAllPlayerAndMonster();
            LevelManager.iconLevel.visible = false;
            conLevel["mc_mov"].visible = true;
            AnimateManager.playMcAnimate(conLevel["mc_mov"],0,"",function():void
            {
               KTool.showMapAllPlayerAndMonster();
               LevelManager.iconLevel.visible = true;
               if(conLevel["mc_npc"])
               {
                  conLevel["mc_mov"].visible = false;
                  initNpc();
               }
            });
         }
      }
      
      override public function destroy() : void
      {
         conLevel["mc_npc"]["mc_qia"].removeEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function initNpc() : void
      {
         conLevel["mc_npc"].visible = true;
         conLevel["mc_npc"]["mc_qia"].buttonMode = true;
         conLevel["mc_npc"]["mc_qia"].addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         conLevel["mc_npc"]["mc_qia"].removeEventListener(MouseEvent.CLICK,this.onClick);
         KTool.getMultiValue([11591],function(param1:Array):void
         {
            var arr:Array = param1;
            conLevel["mc_npc"]["mc_qia"].addEventListener(MouseEvent.CLICK,onClick);
            if(arr[0] < 5)
            {
               NpcDialog.show(1511,["想要我放了年君，就拿0xFF00005000赛尔豆0xFFFFFF意思一下吧！说不定年君会0xFF0000给你一些礼物0xFFFFFF作为回报呢，哈哈！"],["可恶！拿去，你这个魔头！","我不想要什么礼物，也不会给你赛尔豆！"],[sayYes]);
            }
            else
            {
               NpcDialog.show(1511,["哈哈哈，小小年君，也来找我理论！你走吧，这点小心意我就收下了！"],[""],[function():void
               {
                  MapManager.changeMap(1054);
               }]);
            }
         });
      }
      
      private function sayYes() : void
      {
         if(MainManager.actorInfo.coins >= 5000)
         {
            NpcDialog.show(2313,["亲爱的赛尔，真的谢谢你。这个新春爆竹就送给你吧！"],[""],[function():void
            {
               SocketConnection.send(41582,1);
            }]);
         }
         else
         {
            NpcDialog.show(1511,["小滑头，没有赛尔豆也敢来消遣我！"]);
         }
      }
   }
}

