package com.robot.app.mapProcess
{
   import com.robot.app.fight.FightManager;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.manager.ItemManager;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.ui.alert.Alarm;
   import com.robot.core.ui.alert.Alert;
   import com.robot.core.utils.CommonUI;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   public class MapProcess_11465 extends BaseMapProcess
   {
      
      private var itemNum:int = 0;
      
      private var curBuffLevel:int = 0;
      
      private var curLevel:int = 1;
      
      private var hpArr:Array = [0,0,0,0];
      
      private var hpStrArr:Array = ["赛","梦","不","熄"];
      
      public function MapProcess_11465()
      {
         super();
      }
      
      override protected function init() : void
      {
         LevelManager.iconLevel.visible = false;
         ToolBarController.panel.visible = false;
         LevelManager.toolsLevel.visible = false;
         conLevel.addEventListener(MouseEvent.CLICK,this.onConClick);
         this.update();
      }
      
      public function update() : void
      {
         KTool.getMultiValue([14451,14452,4717,4715],function(param1:Array):void
         {
            var a:Array = param1;
            var i:int = 1;
            while(i <= hpArr.length)
            {
               hpArr[i - 1] = KTool.getBit(a[3],16 + i);
               i++;
            }
            curLevel = a[0] + 1;
            curBuffLevel = a[1];
            (conLevel["tips"] as SimpleButton).overState["txt_1"].text = "与炽凰•朱雀对战时我方受到减少" + [0,5,10,20,30,40,50,60,70,80,90][curBuffLevel] + "%伤害，造成增加" + [0,5,10,20,30,40,50,60,70,80,90][curBuffLevel] + "%。";
            CommonUI.setEnabled(conLevel["spend"],curBuffLevel < 10,curBuffLevel >= 10);
            conLevel["mc_1"].gotoAndStop(curLevel);
            conLevel["txt_2"].text = "LV." + curBuffLevel;
            ItemManager.updateAndGetItemsNum([1712254],function(param1:Array):void
            {
               var num:Array = param1;
               itemNum = num[0];
               conLevel["txt_3"].text = String(itemNum) + "/10";
               if(curLevel > 3)
               {
                  Alarm.show("恭喜你已经通关~",function():void
                  {
                     KTool.changeMapWithCallBack(1,function():void
                     {
                        ModuleManager.showAppModule("XinChongMengChongBigHappyMainPanel");
                     });
                  });
               }
            });
         });
      }
      
      public function onConClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         switch(e.target.name)
         {
            case "boss":
               FightManager.fightNoMapBoss("小印",[8998,9000,9001][this.curLevel - 1],false,true,function():void
               {
                  KTool.getMultiValue([14451,4715],function(param1:Array):void
                  {
                     var i:int = 0;
                     var a:Array = param1;
                     if(FightManager.isWin)
                     {
                        i = 1;
                        while(i <= hpArr.length)
                        {
                           if(hpArr[i - 1] != KTool.getBit(a[1],16 + i))
                           {
                              Alarm.show("恭喜你获得了[" + hpStrArr[i - 1] + "]字！");
                              break;
                           }
                           i++;
                        }
                        if(a[0] == 0)
                        {
                           Alarm.show("恭喜你已经通关~",function():void
                           {
                              KTool.changeMapWithCallBack(1,function():void
                              {
                                 ModuleManager.showAppModule("XinChongMengChongBigHappyMainPanel");
                              });
                           });
                        }
                     }
                  });
               });
               break;
            case "xiaoGai":
               FightManager.fightNoMapBoss("小印",this.curLevel == 1 ? 8997 : (this.curLevel == 2 ? 8999 : 0),false,true);
               break;
            case "exit":
               Alert.show("你确定要中止这次闯关吗？下次闯关将从头重新开始！",function():void
               {
                  SocketConnection.sendWithCallback(46310,function(param1:* = null):void
                  {
                     var e:* = param1;
                     KTool.changeMapWithCallBack(1,function():void
                     {
                        ModuleManager.showAppModule("XinChongMengChongBigHappyMainPanel");
                     });
                  },7,0);
                  destroy();
               });
               break;
            case "spend":
               if(this.itemNum < 10)
               {
                  Alarm.show("你当前的冰芒数量不足无法升级。");
                  break;
               }
               SocketConnection.sendWithCallback(46310,function(param1:* = null):void
               {
                  update();
               },5,0);
               break;
            case "onekey_1":
               KTool.buyProductByCallback(249789,1,function():void
               {
                  SocketConnection.sendWithCallback(46310,function(param1:* = null):void
                  {
                     var e:* = param1;
                     KTool.getMultiValue([14451,4715],function(param1:Array):void
                     {
                        var a:Array = param1;
                        var i:int = 1;
                        while(i <= hpArr.length)
                        {
                           if(hpArr[i - 1] != KTool.getBit(a[1],16 + i))
                           {
                              Alarm.show("恭喜你获得了[" + hpStrArr[i - 1] + "]字！");
                              break;
                           }
                           i++;
                        }
                        if(a[0] == 0)
                        {
                           Alarm.show("恭喜你已经通关~",function():void
                           {
                              KTool.changeMapWithCallBack(1,function():void
                              {
                                 ModuleManager.showAppModule("XinChongMengChongBigHappyMainPanel");
                              });
                           });
                        }
                     });
                  },6,0);
               });
         }
      }
      
      override public function destroy() : void
      {
         LevelManager.iconLevel.visible = true;
         ToolBarController.panel.visible = true;
         LevelManager.toolsLevel.visible = true;
         if(conLevel != null)
         {
            conLevel.removeEventListener(MouseEvent.CLICK,this.onConClick);
         }
         super.destroy();
      }
   }
}

