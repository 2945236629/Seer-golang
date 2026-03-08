package com.robot.app.mapProcess
{
   import com.robot.app.fight.*;
   import com.robot.app.fightNote.*;
   import com.robot.core.animate.*;
   import com.robot.core.dispatcher.*;
   import com.robot.core.event.*;
   import com.robot.core.info.fightInfo.attack.*;
   import com.robot.core.manager.*;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.mode.*;
   import com.robot.core.npc.*;
   import com.robot.core.utils.*;
   import flash.events.*;
   import flash.geom.*;
   import org.taomee.manager.*;
   
   public class MapProcess_442 extends BaseMapProcess
   {
      
      public static var isFromShip:Boolean;
      
      private static var _map:BaseMapProcess;
      
      private var _bossMC:BossModel;
      
      public function MapProcess_442()
      {
         super();
      }
      
      override protected function init() : void
      {
         _map = this;
         if(isFromShip)
         {
            isFromShip = false;
            conLevel["monster"].visible = true;
            this.sptPre();
         }
         else
         {
            conLevel["monster"].visible = false;
         }
         var _loc1_:int = 0;
         while(_loc1_ < conLevel.numChildren)
         {
            conLevel.getChildAt(_loc1_).visible = false;
            _loc1_++;
         }
         conLevel["monster"].visible = false;
         this.inita();
      }
      
      private function onMonsterClick(param1:MouseEvent) : void
      {
         FightManager.fightWithBoss("巨型章鱼",5);
         FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,this.onFightOver);
      }
      
      private function sptPre() : void
      {
         AnimateManager.playMcAnimate(_map.conLevel["monster"],1,"mc1",function():void
         {
            NpcDialog.show(NPC.SEER,["果然有异常，这家伙一看就不是什么好料，看我不好好教训他！"],["怪物，不准你再胡作非为！"],[function():void
            {
               NpcDialog.show(NPC.JUXINGZHANGYU,["哈哈哈…怪物？你居然敢在这样的环境下对我如此无礼，看来你是想一直在这里陪我了！"],["没错，我就是来击败你的！"],[function():void
               {
                  NpcDialog.show(NPC.JUXINGZHANGYU,["哼哼…你如此大胆，你妈妈知道吗？看来是该教训你的时候了！"],["可恶的家伙！"],[function():void
                  {
                     AnimateManager.playMcAnimate(_map.conLevel["monster"],2,"mc2",function():void
                     {
                        NpcDialog.show(NPC.SEER,["什么！！！这家伙居然变的如此巨大，看来又是一番恶战了！"],["接招吧！巨型章鱼！","让我先准备一下！"],[function():void
                        {
                           FightManager.fightWithBoss("巨型章鱼",5);
                           FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,onFightOver);
                        },function():void
                        {
                           _map.conLevel["monster"].buttonMode = true;
                           _map.conLevel["monster"].gotoAndStop(3);
                           _map.conLevel["monster"].addEventListener(MouseEvent.CLICK,onMonsterClick);
                        }]);
                     });
                  }]);
               }]);
            }]);
         });
      }
      
      private function onFightOver(param1:PetFightEvent) : void
      {
         var info:FightOverInfo = null;
         var e:PetFightEvent = param1;
         FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,this.onFightOver);
         info = e.dataObj as FightOverInfo;
         _map.conLevel["monster"].visible = true;
         _map.conLevel["monster"].gotoAndStop(3);
         if(info.winnerID == MainManager.actorID)
         {
            NpcDialog.show(NPC.JUXINGZHANGYU,["我…我居然会败在你的手中，这不科学，在海底我才是最强的！"],["我看你还是省省吧！"],[function():void
            {
               AnimateManager.playMcAnimate(_map.conLevel["monster"],3,"mc3",function():void
               {
                  NpcDialog.show(NPC.SEER,["我警告你，不准你再在尼古尔星胡作非为，再让我知道，我就让你变成章鱼小丸子，听到没…"],["哼…下次我一定会战胜你的！"],[function():void
                  {
                     NpcDialog.show(NPC.SEER,["看来你还是不死心，等我向苏克汇报好这里的情况再来教育你，你就等着吧！"],["立刻向苏克汇报！"],[function():void
                     {
                        MapProcess_57.fightWithSuc = true;
                        MapManager.changeMap(57);
                     }]);
                  }]);
               });
            }]);
         }
         else
         {
            NpcDialog.show(NPC.JUXINGZHANGYU,["哈哈，早就告诉你在这样的环境下，你是不可能战胜我的！"],["我就不信战胜不了你，再来！","让我再准备一下！"],[function():void
            {
               FightManager.fightWithBoss("巨型章鱼",5);
               FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,onFightOver);
            },function():void
            {
               _map.conLevel["monster"].addEventListener(MouseEvent.CLICK,onMonsterClick);
            }]);
         }
      }
      
      private function inita() : void
      {
         if(!this._bossMC)
         {
            this._bossMC = new BossModel(347,48);
            this._bossMC.setDirection(Direction.DOWN);
            this._bossMC.show(new Point(500,210),0);
            var _temp_1:* = this._bossMC;
            this._bossMC.scaleY = 3;
            _temp_1.scaleX = 3;
         }
         this._bossMC.mouseEnabled = true;
         this._bossMC.addEventListener(MouseEvent.CLICK,this.onBossClick);
         ToolTipManager.add(this._bossMC,"远古鱼龙");
      }
      
      private function des() : void
      {
         ToolTipManager.remove(this._bossMC);
         this._bossMC.removeEventListener(MouseEvent.CLICK,this.onBossClick);
      }
      
      private function onBossClick(param1:MouseEvent) : void
      {
         FightInviteManager.fightWithBoss("远古鱼龙");
      }
      
      override public function destroy() : void
      {
      }
   }
}

