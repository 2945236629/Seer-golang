package com.robot.app.mapProcess
{
   import com.robot.app.fight.*;
   import com.robot.app.fightNote.*;
   import com.robot.core.event.*;
   import com.robot.core.manager.*;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.*;
   import flash.events.*;
   import flash.external.*;
   import flash.utils.*;
   import org.taomee.manager.*;
   
   public class MapProcess_413 extends BaseMapProcess
   {
      
      public function MapProcess_413()
      {
         super();
      }
      
      override protected function init() : void
      {
         var _loc2_:Object = null;
         var _loc1_:int = 0;
         while(_loc1_ < conLevel.numChildren)
         {
            _loc2_ = conLevel.getChildAt(_loc1_);
            if(_loc2_ != null)
            {
               ExternalInterface.call("console.log","Child Index: " + _loc1_ + ", Child: " + _loc2_);
            }
            _loc1_++;
         }
         setTimeout(this.startDialog,2000);
      }
      
      private function startDialog() : void
      {
         if(MainManager.actorInfo.mapID != 413)
         {
            return;
         }
         NpcDialog.show(NPC.ALLISON,["哈哈，小子，你来干嘛？"],["艾里逊绑架了我的朋友们，我要去救他们！"],[function():void
         {
            NpcDialog.show(NPC.ALLISON,["哈哈哈，有胆量！那就让我看看你有什么本事！"],["放马过来吧！","算了算了，我先去其他地方看看吧！"],[function():void
            {
               NpcDialog.show(NPC.ALLISON,["小子，必须在30回合内战胜我才算数！哈哈哈，盖亚也被我们控制了[8回合内全程先手击败我可以获得全新称号]"],["我来解救盖亚！"],[function():void
               {
                  NpcDialog.show(NPC.ALLISON,["记住，在对战中不能使用药剂，准备好了吗？"],["达尔我会救出你的！"],[function():void
                  {
                     FightInviteManager.fightWithBoss("艾里逊");
                     EventManager.addEventListener(PetFightEvent.FIGHT_CLOSE,onFightClose);
                  }]);
               }]);
            },function():void
            {
               MapManager.changeMap(412);
            }]);
         }]);
      }
      
      private function onFightClose(param1:PetFightEvent) : void
      {
         EventManager.removeEventListener(PetFightEvent.FIGHT_CLOSE,this.onFightClose);
         MapManager.changeMap(412);
      }
      
      private function onClickHandler(param1:MouseEvent) : void
      {
         FightManager.fightWithBoss("阿索卡",1);
      }
      
      override public function destroy() : void
      {
         var _loc1_:Object = conLevel.getChildAt(0);
         if(_loc1_ != null && Boolean(_loc1_.hasEventListener(MouseEvent.CLICK)))
         {
            _loc1_.removeEventListener(MouseEvent.CLICK,this.onClickHandler);
         }
         EventManager.removeEventListener(PetFightEvent.FIGHT_CLOSE,this.onFightClose);
      }
   }
}

