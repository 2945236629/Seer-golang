package com.robot.app.mapProcess
{
   import com.robot.app.fight.FightManager;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.BitBuffSetClass;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NpcDialog;
   import flash.events.MouseEvent;
   
   public class MapProcess_10808 extends BaseMapProcess
   {
      
      private var _num:uint;
      
      public function MapProcess_10808()
      {
         super();
      }
      
      override protected function init() : void
      {
         conLevel["mc_mov"].visible = false;
         conLevel["mc_npc"].visible = false;
         if(BitBuffSetClass.getState(22638))
         {
            this.initNpc();
         }
         else
         {
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
         conLevel["mc_npc"]["mc_long"].removeEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function initNpc() : void
      {
         conLevel["mc_npc"].visible = true;
         conLevel["mc_npc"]["mc_long"].buttonMode = true;
         conLevel["mc_npc"]["mc_long"].addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         conLevel["mc_npc"]["mc_long"].removeEventListener(MouseEvent.CLICK,this.onClick);
         KTool.getMultiValue([11593],function(param1:Array):void
         {
            var arr:Array = param1;
            _num = arr[0];
            if(!BitBuffSetClass.getState(22638) && _num < 5)
            {
               BitBuffSetClass.setState(22638,1);
               conLevel["mc_npc"]["mc_long"].addEventListener(MouseEvent.CLICK,onClick);
               NpcDialog.show(2314,["是谁在那里鬼鬼祟祟！"],[""],[function():void
               {
                  NpcDialog.show(2312,["不好，被发现了！"],[""],[function():void
                  {
                     NpcDialog.show(2314,["这家伙鬼鬼祟祟，肯定不干好事！帮我挡住他，别让他跑了！若能抓住，0xFF0000重重有赏0xFFFFFF！"],[""],[function():void
                     {
                        NpcDialog.show(2312,["嘻嘻，就凭你？你只要在我手里0xFF0000坚持5回合0xFFFFFF，我就留下来陪你们玩玩，如何？！"],[""],[function():void
                        {
                           NpcDialog.show(20,["放着我来！"],[""],[fightBoss]);
                        }]);
                     }]);
                  }]);
               }]);
            }
            else
            {
               conLevel["mc_npc"]["mc_long"].addEventListener(MouseEvent.CLICK,onClick);
               fightHandler();
            }
         });
      }
      
      private function fightHandler() : void
      {
         if(this._num < 5)
         {
            NpcDialog.show(2314,["别让他跑了！若能抓住，0xFF0000重重有赏0xFFFFFF！记住，你只要0xFF0000坚持5回合0xFFFFFF就可以了！"],["放马过来！","还是算了吧"],[this.fightBoss]);
         }
         else
         {
            NpcDialog.show(2314,["怎样，他坚持了5个回合，你是否该履行你的诺言留下来？"],[""],[function():void
            {
               NpcDialog.show(2312,["哈哈哈，诺言是什么？愚蠢的正义之士，我走了！"],[""],[function():void
               {
                  NpcDialog.show(2312,["你竟敢……可恶！"],[""],[chageMap]);
               }]);
            }]);
         }
      }
      
      private function fightBoss() : void
      {
         FightManager.fightNoMapBoss("力丸",3154);
      }
      
      private function chageMap() : void
      {
         MapManager.changeMap(1053);
      }
   }
}

