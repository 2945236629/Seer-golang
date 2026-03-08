package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.dispatcher.FightDispatcher;
   import com.robot.core.event.PetFightEvent;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.StatManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NpcDialog;
   import com.robot.core.ui.alert.Alarm;
   import com.robot.core.utils.CommonUI;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import org.taomee.manager.EventManager;
   
   public class MapProcess_11701 extends BaseMapProcess
   {
      
      private const PETIDS:Array = [1332,62,3041,3349,3588,3656,3710];
      
      private var pro:int;
      
      public function MapProcess_11701()
      {
         super();
      }
      
      override protected function init() : void
      {
         topLevel["tip"].visible = false;
         topLevel.addEventListener(MouseEvent.CLICK,this.clickHandle);
         conLevel.addEventListener(MouseEvent.CLICK,this.clickHandle);
         EventManager.addEventListener("GUGUFA_MAKE",this.makeHandle);
         EventManager.addEventListener("GUGUFA_SHOWTIP",this.showtipHandle);
         this.update();
      }
      
      private function showtipHandle(param1:Event) : void
      {
         topLevel["tip"].visible = true;
      }
      
      private function makeHandle(param1:Event) : void
      {
         this.update();
      }
      
      private function update() : void
      {
         LevelManager.closeMouseEvent();
         KTool.getMultiValue([16928,104492],function(param1:Array):void
         {
            var _loc2_:* = param1[0] >> 8 & 0x0F;
            var _loc3_:* = _loc2_ >= 3;
            var _loc4_:* = _loc2_ >= 2;
            pro = param1[1] & 0x0F;
            var _loc5_:int = 0;
            while(_loc5_ < 7)
            {
               CommonUI.setEnabled(conLevel["npc_" + _loc5_],_loc4_ && !_loc3_,false);
               conLevel["npc_" + _loc5_].visible = _loc4_;
               _loc5_++;
            }
            topLevel["tip"]["mc"].gotoAndStop(pro + 1);
            conLevel["mc"].visible = _loc4_ && !_loc3_;
            LevelManager.openMouseEvent();
         });
      }
      
      private function clickHandle(param1:MouseEvent) : void
      {
         var idx:int = 0;
         var e:MouseEvent = param1;
         var ename:String = e.target.name;
         if(ename.indexOf("npc_") != -1)
         {
            idx = int(ename.split("_")[1]);
            if(this.pro == idx)
            {
               StatManager.sendStat2014("0817主题活动","将巧果送给正确的人","2018运营活动");
               NpcDialog.show(this.PETIDS[idx],["谢谢你的心意！……天呐，这个巧果做的真可爱！"],["不客气！"],[function():void
               {
                  SocketConnection.sendByQueue(43300,[17,idx + 6],function(param1:*):void
                  {
                     update();
                     Alarm.show("你与菇菇发的友情点增加了35点！");
                     ModuleManager.showAppModule("GugufaGiftMainPanel");
                  });
               }],false,null,true);
            }
            else
            {
               StatManager.sendStat2014("0817主题活动","将巧果送给错误的人","2018运营活动");
               NpcDialog.show(this.PETIDS[idx],["谢谢你的心意！……嗯？这个好像不是给我的礼物吧？你是不是在逗我？"],["哎呀，搞错人啦！"],[function():void
               {
                  FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,function(param1:PetFightEvent):void
                  {
                     FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,arguments.callee);
                  });
                  SocketConnection.sendByQueue(43300,[17,idx + 6]);
               }],false,null,true);
            }
            return;
         }
         switch(ename)
         {
            case "close":
            case "ok":
               topLevel["tip"].visible = false;
               break;
            case "see":
               StatManager.sendStat2014("0817主题活动","点击场景中的查看巧果按钮","2018运营活动");
               topLevel["tip"].visible = true;
         }
      }
      
      override public function destroy() : void
      {
         EventManager.removeEventListener("GUGUFA_SHOWTIP",this.showtipHandle);
         EventManager.removeEventListener("GUGUFA_MAKE",this.makeHandle);
         topLevel.removeEventListener(MouseEvent.CLICK,this.clickHandle);
         conLevel.removeEventListener(MouseEvent.CLICK,this.clickHandle);
         super.destroy();
      }
   }
}

