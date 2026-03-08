package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.BitBuffSetClass;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NpcDialog;
   import flash.events.MouseEvent;
   
   public class MapProcess_10809 extends BaseMapProcess
   {
      
      private var _num:uint;
      
      public function MapProcess_10809()
      {
         super();
      }
      
      override protected function init() : void
      {
         conLevel["mc_mov"].visible = false;
         conLevel["mc_npc"].visible = false;
         if(BitBuffSetClass.getState(22639))
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
         conLevel["mc_npc"]["mc_nian"].removeEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function initNpc() : void
      {
         conLevel["mc_npc"].visible = true;
         conLevel["mc_npc"]["mc_nian"].buttonMode = true;
         conLevel["mc_npc"]["mc_nian"].addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         conLevel["mc_npc"]["mc_nian"].removeEventListener(MouseEvent.CLICK,this.onClick);
         KTool.getMultiValue([11594],function(param1:Array):void
         {
            var arr:Array = param1;
            _num = arr[0];
            if(!BitBuffSetClass.getState(22639) && _num < 5)
            {
               BitBuffSetClass.setState(22639,1);
               conLevel["mc_npc"]["mc_nian"].addEventListener(MouseEvent.CLICK,onClick);
               NpcDialog.show(2313,["几大冥王看起来势均力敌，都非常强大啊！怎么样，有没有信心？"],[""],[function():void
               {
                  NpcDialog.show(2313,["这样吧，0xFF0000你每挑战一次冥王0xFFFFFF，我便0xFF0000给你一份奖励0xFFFFFF，怎么样？"],["没有问题，看我的！"],[chageMap]);
               }]);
            }
            else
            {
               fightHandler();
            }
         });
      }
      
      private function fightHandler() : void
      {
         if(this._num < 5)
         {
            NpcDialog.show(2313,["0xFF0000你每挑战一次冥王0xFFFFFF，我便0xFF0000给你一份奖励哦0xFFFFFF，有没有信心？"],["没有问题，看我的！"],[this.chageMap]);
         }
         else
         {
            NpcDialog.show(22638,["小伙子，实力不错嘛！看你战斗几场下来也气喘吁吁了，今日便稍作休息吧！明天别忘了来哦！"],["好的，明天我会来的！"],[this.chageMap]);
         }
      }
      
      private function chageMap() : void
      {
         MapManager.changeMap(1059);
      }
   }
}

