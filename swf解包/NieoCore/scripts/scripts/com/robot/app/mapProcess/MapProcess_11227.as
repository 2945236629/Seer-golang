package com.robot.app.mapProcess
{
   import com.robot.app.fight.FightManager;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.dispatcher.FightDispatcher;
   import com.robot.core.event.PetFightEvent;
   import com.robot.core.manager.ItemManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.StatManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.mode.OgreModel;
   import com.robot.core.ui.alert.Alarm;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class MapProcess_11227 extends BaseMapProcess
   {
      
      private var pos:Array = [{
         "x":300,
         "y":400
      },{
         "x":400,
         "y":300
      },{
         "x":450,
         "y":360
      },{
         "x":550,
         "y":350
      },{
         "x":600,
         "y":400
      }];
      
      private var monsters:Array;
      
      public function MapProcess_11227()
      {
         super();
      }
      
      override protected function init() : void
      {
         var _loc2_:OgreModel = null;
         this.monsters = [];
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            _loc2_ = new OgreModel(0);
            _loc2_.show(293,new Point(this.pos[_loc1_].x,this.pos[_loc1_].y));
            _loc2_.addEventListener(MouseEvent.CLICK,this.clickHandle);
            conLevel.addChild(_loc2_);
            this.monsters.push(_loc2_);
            _loc1_++;
         }
      }
      
      private function clickHandle(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         KTool.getMultiValue([12464,12463],function(param1:Array):void
         {
            var arr:Array = param1;
            KTool.getBitSet([19450],function(param1:Array):void
            {
               var arr1:Array = param1;
               ItemManager.updateItems([1709455],function():void
               {
                  var itemnum:int = int(ItemManager.getNumByID(1709455));
                  if(arr1[0])
                  {
                     Alarm.show("你已经兑换了小嘉！");
                  }
                  else if(itemnum >= 50)
                  {
                     Alarm.show("你已经获得了足够兑换小嘉的周年庆纹章，快去兑换它吧！",function():void
                     {
                        ModuleManager.showAppModule("AnniversarySpiritePanel");
                     });
                  }
                  else if(arr[0] >= 20)
                  {
                     Alarm.show("今日获得的周年庆纹章已达到上限，请明天再来挑战或者前往活动面板购买！",function():void
                     {
                        ModuleManager.showAppModule("AnniversarySpiritePanel");
                     });
                  }
                  else
                  {
                     fight(arr[1],arr[0]);
                  }
               });
            });
         });
      }
      
      private function fight(param1:int, param2:int) : void
      {
         var num1:int = param1;
         var num2:int = param2;
         StatManager.sendStat2014("0513周年庆神秘嘉宾登场","开始挑战迷你芽","2016运营活动");
         FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,function(param1:PetFightEvent):void
         {
            var e:PetFightEvent = param1;
            FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,arguments.callee);
            if(e.dataObj.winnerID == MainManager.actorInfo.userID)
            {
               KTool.getMultiValue([12464],function(param1:Array):void
               {
                  if(num1 >= 10 && num2 < 20 && param1[0] == num2)
                  {
                     Alarm.show("今日获得其他奖励次数已达到上限，所以未能获得奖励，但挑战仍有机会获得周年庆纹章！");
                  }
               });
            }
         });
         FightManager.fightNoMapBoss("迷你芽",7090);
      }
      
      override public function destroy() : void
      {
         var _loc1_:OgreModel = null;
         if(this.monsters)
         {
            for each(_loc1_ in this.monsters)
            {
               _loc1_.removeEventListener(MouseEvent.CLICK,this.clickHandle);
               if(_loc1_.parent)
               {
                  _loc1_.parent.removeChild(_loc1_);
               }
               _loc1_ = null;
            }
            this.monsters = null;
         }
      }
   }
}

