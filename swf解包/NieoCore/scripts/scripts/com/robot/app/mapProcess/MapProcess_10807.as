package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.BitBuffSetClass;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.SystemTimerManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NpcDialog;
   import flash.events.MouseEvent;
   
   public class MapProcess_10807 extends BaseMapProcess
   {
      
      private var _num:uint;
      
      public function MapProcess_10807()
      {
         super();
      }
      
      override protected function init() : void
      {
         conLevel["mc_mov"].visible = false;
         conLevel["mc_npc"].visible = false;
         if(BitBuffSetClass.getState(22637))
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
         var date:Date = null;
         var e:MouseEvent = param1;
         conLevel["mc_npc"]["mc_nian"].removeEventListener(MouseEvent.CLICK,this.onClick);
         if(!BitBuffSetClass.getState(22637))
         {
            BitBuffSetClass.setState(22637,1);
            conLevel["mc_npc"]["mc_nian"].addEventListener(MouseEvent.CLICK,this.onClick);
            NpcDialog.show(2313,["不如我去帮你做做宣传吧！愿神谕天启军越来越强大！"],[""],[function():void
            {
               NpcDialog.show(2303,["哈哈哈，好，年君的话我一直非常相信！我也不劳烦年君为天启军倾尽心血，一天之内，只需要帮我宣传半个小时就行了！"],["没问题，小意思！"],[function():void
               {
                  NpcDialog.show(2303,["0xFF0000每天16:00-18:00间0xFFFFFF，所有0xFF0000在线满30分钟0xFFFFFF的小赛尔都可以直接来我这里0xFF0000领取5份新春爆竹0xFFFFFF！别忘了来哦！"],["不会的！"],[checkLimit]);
               }]);
            }]);
         }
         else
         {
            date = SystemTimerManager.sysBJDate;
            if(date.hours >= 16 && date.hours <= 17 && MainManager.actorInfo.onlineTime >= 1800)
            {
               this.checkLimit();
            }
            else
            {
               conLevel["mc_npc"]["mc_nian"].addEventListener(MouseEvent.CLICK,this.onClick);
               NpcDialog.show(2303,["0xFF0000每天16:00-18:00间0xFFFFFF，所有0xFF0000在线满30分钟0xFFFFFF的小赛尔都可以直接来我这里0xFF0000领取5份新春爆竹0xFFFFFF！别忘了来哦！"],["不会的！"]);
            }
         }
      }
      
      private function checkLimit() : void
      {
         KTool.getMultiValue([11592],function(param1:Array):void
         {
            var date:Date = null;
            var arr:Array = param1;
            if(arr[0] < 1)
            {
               date = SystemTimerManager.sysBJDate;
               if(date.hours >= 16 && date.hours <= 17 && MainManager.actorInfo.onlineTime >= 1800)
               {
                  NpcDialog.show(2303,["谢谢你辛苦为我做的宣传，这份奖励就给你吧！0xFF0000如果想要更多奖励，明天也可以继续做宣传哦0xFFFFFF！"],["谢谢克洛伊大人！"],[function():void
                  {
                     SocketConnection.sendWithCallback(41582,function():void
                     {
                        MapManager.changeMap(1053);
                     },2);
                  }]);
               }
            }
            else
            {
               NpcDialog.show(2303,["今天就到这里吧，辛苦你了小赛尔。"],["好哒！"],[function():void
               {
                  MapManager.changeMap(1053);
               }]);
            }
         });
      }
   }
}

