package com.robot.app.mapProcess
{
   import com.robot.app.buyItem.ProductAction;
   import com.robot.app.control.BonusController;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.CommandID;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.event.RobotEvent;
   import com.robot.core.manager.ItemManager;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.TasksManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.ui.alert.Alarm;
   import com.robot.core.ui.alert.Alert;
   import com.robot.core.utils.Direction;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.ByteArray;
   import org.taomee.events.DynamicEvent;
   import org.taomee.events.SocketEvent;
   import org.taomee.manager.EventManager;
   
   public class MapProcess_10443 extends BaseMapProcess
   {
      
      private const PRE_TASK:int = 1927;
      
      private const ACTIVATED_FOREVER:int = 771;
      
      private var _activatedCount:int;
      
      private var buyArr:Array = [null,{
         "product":201358,
         "item":1700516
      },{
         "product":201359,
         "item":1700517
      },{
         "product":201360,
         "item":1700518
      },{
         "product":201361,
         "item":1700519
      },{
         "product":201362,
         "item":1700520
      },{
         "product":201376,
         "item":1700534
      }];
      
      private var bitArr:Array = [{
         "pos":22402,
         "value":0
      },{
         "pos":22403,
         "value":0
      },{
         "pos":22404,
         "value":0
      },{
         "pos":22405,
         "value":0
      },{
         "pos":22406,
         "value":0
      },{
         "pos":22407,
         "value":0
      },{
         "pos":22408,
         "value":0
      }];
      
      private var magicPos:Array;
      
      private var currentIndex:int;
      
      public function MapProcess_10443()
      {
         super();
      }
      
      override protected function init() : void
      {
         topLevel.mouseChildren = topLevel.mouseEnabled = false;
         SocketConnection.send(1022,86068909);
         this.hideIconAndToolsLevel();
         this.checkPreTask();
         this.addEvents();
         this.updateStatus();
         AnimateManager.playMcAnimate(depthLevel["pet"],1,"mc1",function():void
         {
            KTool.getFrameMc(depthLevel["pet"],1,"mc1",function(param1:MovieClip):void
            {
               param1.gotoAndStop(param1.totalFrames);
            });
         });
      }
      
      override public function destroy() : void
      {
         this.buyArr = null;
         this.magicPos = null;
         this.bitArr = null;
         this.removeEvents();
         LevelManager.iconLevel.visible = LevelManager.toolsLevel.visible = true;
      }
      
      private function hideIconAndToolsLevel() : void
      {
         LevelManager.iconLevel.visible = LevelManager.toolsLevel.visible = false;
      }
      
      private function updateStatus() : void
      {
         var i:int;
         var sendArr:Array = null;
         var obj:Object = null;
         KTool.getForeverNum(this.ACTIVATED_FOREVER,function(param1:int):void
         {
            _activatedCount = param1;
            conLevel["guide"].visible = Boolean(_activatedCount == 0);
         });
         this.magicPos = new Array();
         i = 0;
         while(i < 7)
         {
            this.magicPos.push({
               "x":conLevel["magic_" + i].x,
               "y":conLevel["magic_" + i].y,
               "w":conLevel["magic_" + i].width,
               "h":conLevel["magic_" + i].height
            });
            i++;
         }
         sendArr = new Array();
         for each(obj in this.bitArr)
         {
            sendArr.push(obj.pos);
         }
         KTool.getBitSet(sendArr,function(param1:Array):void
         {
            var _loc2_:int = 0;
            while(_loc2_ < sendArr.length)
            {
               bitArr[_loc2_].value = param1[_loc2_];
               if(bitArr[_loc2_].value)
               {
                  conLevel["magic_" + _loc2_].gotoAndStop(2);
               }
               _loc2_++;
            }
         });
      }
      
      private function addEvents() : void
      {
         MapListenerManager.add(btnLevel["intro"],this.onIntro);
         MapListenerManager.add(btnLevel["task"],this.onTask);
         MapListenerManager.add(btnLevel["direct"],this.onDirect);
         MapListenerManager.add(btnLevel["close"],this.onClose);
         var _loc1_:int = 0;
         while(_loc1_ < 7)
         {
            conLevel["magic_" + _loc1_].buttonMode = true;
            conLevel["magic_" + _loc1_].addEventListener(MouseEvent.CLICK,this.onMagic);
            _loc1_++;
         }
      }
      
      private function removeEvents() : void
      {
         EventManager.removeEventListener(RobotEvent.MONEY_BUY,this.onMoneyBuy);
         EventManager.removeEventListener(RobotEvent.CANCEL_MONEY_BUY,this.onCancelBuy);
         MainManager.actorModel.removeEventListener(RobotEvent.WALK_START,this.onWalkStart);
         MainManager.actorModel.removeEventListener(RobotEvent.WALK_END,this.onWalkEnd);
         var _loc1_:int = 0;
         while(_loc1_ < 7)
         {
            conLevel["magic_" + _loc1_].removeEventListener(MouseEvent.CLICK,this.onMagic);
            _loc1_++;
         }
      }
      
      private function onMoneyBuy(param1:DynamicEvent) : void
      {
         this.onCancelBuy(null);
         this.do_activate();
      }
      
      private function onCancelBuy(param1:RobotEvent) : void
      {
         EventManager.removeEventListener(RobotEvent.MONEY_BUY,this.onMoneyBuy);
         EventManager.removeEventListener(RobotEvent.CANCEL_MONEY_BUY,this.onCancelBuy);
      }
      
      private function onClose(param1:MouseEvent) : void
      {
         var _loc2_:int = int(MapManager.prevMapID);
         if(_loc2_ > 10000 && _loc2_ < 50000)
         {
            MapManager.changeLocalMap(_loc2_);
         }
         else
         {
            MapManager.changeMap(_loc2_);
         }
      }
      
      private function onIntro(param1:MouseEvent) : void
      {
         ModuleManager.showModule(ClientConfig.getAppModule("ApolloIntroPanel"));
      }
      
      private function onTask(param1:MouseEvent) : void
      {
         SocketConnection.send(1022,86068927);
         this.playFullMovie();
      }
      
      private function onDirect(param1:MouseEvent) : void
      {
         SocketConnection.send(1022,86068922);
         ModuleManager.showModule(ClientConfig.getAppModule("ApolloDirectPanel"));
      }
      
      private function onMagic(param1:MouseEvent) : void
      {
         var tX:Number = NaN;
         var tY:Number = NaN;
         var e:MouseEvent = param1;
         var circle:MovieClip = e.currentTarget as MovieClip;
         var index:int = int(circle.name.split("_")[1]);
         if(index != 6)
         {
            SocketConnection.send(1022,this._activatedCount % 7 * 2 + 86068910);
         }
         this.currentIndex = index;
         if(this.bitArr[index].value >= 1)
         {
            Alarm.show("你已经激活了该法阵！");
            return;
         }
         tX = this.magicPos[index].x + this.magicPos[index].w / 2;
         tY = this.magicPos[index].y + this.magicPos[index].h / 2;
         MainManager.actorModel.addEventListener(RobotEvent.WALK_START,this.onWalkStart);
         MainManager.actorModel.addEventListener(RobotEvent.WALK_END,this.onWalkEnd);
         MainManager.actorModel.moveAndAction(new Point(tX,tY),function():void
         {
            MainManager.actorModel.x = tX;
            MainManager.actorModel.y = tY;
            MainManager.actorModel.direction = Direction.DOWN;
            if(_activatedCount <= 0 || _activatedCount >= 7)
            {
               Alert.show("开启第一个魔法阵需要消耗20000赛尔豆，是否继续？",function():void
               {
                  if(MainManager.actorInfo.coins < 20000)
                  {
                     Alarm.show("你的赛尔豆不足20000个！");
                     return;
                  }
                  do_activate();
               });
               return;
            }
            ItemManager.upDateCollection(buyArr[_activatedCount].item,function():void
            {
               if(ItemManager.getNumByID(buyArr[_activatedCount].item) > 0)
               {
                  do_activate();
               }
               else
               {
                  EventManager.addEventListener(RobotEvent.MONEY_BUY,onMoneyBuy);
                  EventManager.addEventListener(RobotEvent.CANCEL_MONEY_BUY,onCancelBuy);
                  ProductAction.buyMoneyProduct(buyArr[_activatedCount].product);
               }
            });
         });
      }
      
      private function onWalkStart(param1:RobotEvent) : void
      {
         LevelManager.mapLevel.mouseChildren = LevelManager.mapLevel.mouseEnabled = false;
      }
      
      private function onWalkEnd(param1:RobotEvent) : void
      {
         LevelManager.mapLevel.mouseChildren = LevelManager.mapLevel.mouseEnabled = true;
         MainManager.actorModel.removeEventListener(RobotEvent.WALK_START,this.onWalkStart);
         MainManager.actorModel.removeEventListener(RobotEvent.WALK_END,this.onWalkEnd);
      }
      
      private function do_activate() : void
      {
         BonusController.addDelay(325);
         SocketConnection.sendByQueue(CommandID.APOLLO_ACTIVATE_MAGIC_CIRCLE,null,function(param1:SocketEvent):void
         {
            var result:int;
            var e:SocketEvent = param1;
            var ret:ByteArray = e.data as ByteArray;
            ret.position = 0;
            result = int(ret.readUnsignedInt());
            if(result == 1)
            {
               AnimateManager.playMcAnimate(depthLevel["pet"],2,"mc2",function():void
               {
                  KTool.getFrameMc(depthLevel["pet"],1,"mc1",function(param1:MovieClip):void
                  {
                     param1.gotoAndStop(param1.totalFrames);
                  });
                  Alarm.show("成功召唤太阳神阿波罗！");
                  clearBitSet();
                  BonusController.showDelayBonus(325);
                  updateStatus();
               });
            }
            else
            {
               Alarm.show("魔法阵开启，未能召唤出阿波罗\n开启所有魔法阵必定获得！");
               setBitPos();
            }
         });
      }
      
      private function setBitPos() : void
      {
         SocketConnection.sendByQueue(CommandID.COMMAND_42019,[this.bitArr[this.currentIndex].pos,1],function(param1:SocketEvent):void
         {
            updateStatus();
         });
      }
      
      private function clearBitSet() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.bitArr.length)
         {
            if(this.bitArr[_loc1_].value >= 1)
            {
               SocketConnection.send(CommandID.COMMAND_42019,this.bitArr[_loc1_].pos,0);
            }
            conLevel["magic_" + _loc1_].gotoAndStop(1);
            _loc1_++;
         }
      }
      
      private function checkPreTask() : void
      {
         if(!this.isTaskDone)
         {
            this.playFullMovie(this.completeTask);
         }
      }
      
      private function completeTask() : void
      {
         TasksManager.accept(this.PRE_TASK,function(param1:Boolean):void
         {
            var b1:Boolean = param1;
            TasksManager.complete(PRE_TASK,0,function(param1:Boolean):void
            {
               SocketConnection.send(1022,86068908);
            });
         });
      }
      
      private function playFullMovie(param1:Function = null) : void
      {
         var func:Function = param1;
         AnimateManager.playFullScreenAnimate(ClientConfig.getFullMovie("apollo_full_1"),function():void
         {
            hideIconAndToolsLevel();
            if(null != func)
            {
               func();
            }
         },true);
      }
      
      private function get isTaskDone() : Boolean
      {
         return TasksManager.getTaskStatus(this.PRE_TASK) == TasksManager.COMPLETE;
      }
   }
}

