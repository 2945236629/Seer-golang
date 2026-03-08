package com.robot.app.mapProcess
{
   import com.robot.app.fight.FightManager;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.dispatcher.FightDispatcher;
   import com.robot.core.event.PetFightEvent;
   import com.robot.core.manager.ItemManager;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.mode.OgreModel;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.ui.alert.Alarm2;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class MapProcess_11213 extends BaseMapProcess
   {
      
      private var monsters:Array;
      
      public function MapProcess_11213()
      {
         super();
      }
      
      override protected function init() : void
      {
         var _loc3_:OgreModel = null;
         this.monsters = [];
         var _loc1_:int = 0;
         while(_loc1_ < 4)
         {
            _loc3_ = new OgreModel(0);
            _loc3_.show(30,new Point(300 + 50 * _loc1_,400));
            _loc3_.addEventListener(MouseEvent.CLICK,this.clickHandle);
            conLevel.addChild(_loc3_);
            this.monsters.push(_loc3_);
            _loc1_++;
         }
         var _loc2_:int = 0;
         while(_loc2_ < 5)
         {
            conLevel["kuang_" + _loc2_].buttonMode = true;
            conLevel["kuang_" + _loc2_].visible = false;
            conLevel["kuang_" + _loc2_].addEventListener(MouseEvent.CLICK,this.clickKuangHandle);
            conLevel["kuang_" + _loc2_]["bar"].visible = false;
            _loc2_++;
         }
         this.check();
      }
      
      private function clickKuangHandle(param1:MouseEvent) : void
      {
         var tar:MovieClip = null;
         var e:MouseEvent = param1;
         LevelManager.closeMouseEvent();
         tar = e.currentTarget as MovieClip;
         tar["bar"].visible = true;
         AnimateManager.playMcAnimate(tar["bar"]["mcBar"]["mcBar"],1,"",function():void
         {
            SocketConnection.sendByQueue(47288,[6,0],function(param1:*):void
            {
               tar.visible = false;
               LevelManager.openMouseEvent();
               check();
               checkitemnum();
            });
         });
      }
      
      private function check() : void
      {
         var _loc1_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:Array = [];
         var _loc3_:int = 0;
         while(_loc3_ < 5)
         {
            if(conLevel["kuang_" + _loc3_].visible)
            {
               _loc1_++;
            }
            else
            {
               _loc2_.push(_loc3_);
            }
            _loc3_++;
         }
         while(_loc1_ < 3)
         {
            _loc4_ = Math.round(Math.random() * (_loc2_.length - 1));
            if(!conLevel["kuang_" + _loc2_[_loc4_]].visible)
            {
               conLevel["kuang_" + _loc2_[_loc4_]].visible = true;
               conLevel["kuang_" + _loc2_[_loc4_]]["bar"].visible = false;
               _loc1_++;
            }
         }
      }
      
      private function clickHandle(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,function(param1:PetFightEvent):void
         {
            FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,arguments.callee);
            if(param1.dataObj.winnerID != MainManager.actorInfo.userID)
            {
            }
            checkitemnum();
         });
         FightManager.fightNoMapBoss("",6875);
      }
      
      private function checkitemnum() : void
      {
         KTool.getMultiValue([2797],function(param1:Array):void
         {
            var yizhuru:int = 0;
            var arr:Array = param1;
            yizhuru = arr[0] / 10;
            ItemManager.updateItems([1709038],function():void
            {
               var itemnum:int = int(ItemManager.getNumByID(1709038));
               if(itemnum + yizhuru >= 10)
               {
                  Alarm2.show("已获得足够的极炼魔晶，请前往注入！",function():void
                  {
                     KTool.changeMapWithCallBack(1182,function():void
                     {
                        ModuleManager.showAppModule("DemonGodEvo1Panel");
                     });
                  });
               }
            });
         });
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

