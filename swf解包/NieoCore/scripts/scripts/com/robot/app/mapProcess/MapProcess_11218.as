package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.event.RobotEvent;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   import flash.events.MouseEvent;
   import org.taomee.events.SocketEvent;
   import org.taomee.manager.EventManager;
   
   public class MapProcess_11218 extends BaseMapProcess
   {
      
      private var _compeleteNum:int = 0;
      
      private var _questionArr:Array = ["贾斯汀站长组建的特种部队叫什么？","四九战将升级后将拥有怎样的属性加成？","永夜纪年残页化身利斯塔完全体叫什么？","毁灭魔神超进化叫什么？","四九战将套装升级后共有几件？","没错，为了让四九战将套装升级后更加强大，我设计了战皇假面来提高套装的防御力。小赛尔们只有完成了四件套的升级才可以锻造四九假面完成最终的属性加成哦！"];
      
      private var _answerArr:Array = [["A.银翼部队","B. 赛尔之光","C. 空间之护","B.SPT"],[" A.特防+10% "," B.防御+10% ","C. 先出手时伤害提高30%","D.双防+50点"],["A. 雷利•利斯塔  ","B.雷暴•利斯塔","C.雷伊•利斯塔","D.雷王•利斯塔"],["A.毁世魔屠 ","B.毁伤之灾 ","C. 毁世魔尊 ","D.毁伤邪尊"],["A.3","B.4","C.5"," D.6"],["确定。"]];
      
      private var _rightAnswerArr:Array = ["A","D","B","A","C"];
      
      private var _fun:Function;
      
      private var _isClick:Boolean = false;
      
      public function MapProcess_11218()
      {
         super();
      }
      
      override protected function init() : void
      {
         ToolBarController.panel.visible = false;
         LevelManager.iconLevel.visible = false;
         topLevel.mouseEnabled = false;
         topLevel.mouseChildren = false;
         conLevel.addEventListener(MouseEvent.CLICK,this.onConLevel);
         this.update();
      }
      
      public function onConLevel(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         switch(event.target.name)
         {
            case "closeBtn":
               MapManager.changeMapWithCallback(1,function():void
               {
                  ModuleManager.showModule(ClientConfig.getAppModule("FortyNineWarPackagePlusMainPanel"),"正在打开....");
               });
               break;
            case "aKeyUpgradeBtn":
               KTool.buyProductByCallback(247345,1,function():void
               {
                  SocketConnection.addCmdListener(45641,function(param1:SocketEvent):void
                  {
                     var e:SocketEvent = param1;
                     SocketConnection.removeCmdListener(45641,arguments.callee);
                     MapManager.changeMapWithCallback(1,function():void
                     {
                        ModuleManager.showModule(ClientConfig.getAppModule("FortyNineWarPackagePlusMainPanel"),"正在打开....");
                     });
                  });
                  SocketConnection.send(45641,6,3);
               },conLevel);
               break;
            case "buyBtn":
               EventManager.addEventListener(RobotEvent.CLOSE_MUL_BUY_PANEL,this.onBuySpHandler);
               ModuleManager.showModule(ClientConfig.getAppModule("MultiBuyPanel"),"",{
                  "productID":247351,
                  "iconID":1709128,
                  "exchangeID":8771
               });
               break;
            case "fightBtn":
               this.answerQuestion();
         }
      }
      
      private function onBuySpHandler(param1:*) : void
      {
         EventManager.removeEventListener(RobotEvent.CLOSE_MUL_BUY_PANEL,this.onBuySpHandler);
         this.update();
      }
      
      public function answerQuestion() : void
      {
         NpcDialog.show(NPC.CICI,[this._questionArr[this._compeleteNum]],this._answerArr[this._compeleteNum],[function():void
         {
            if(_compeleteNum < 5)
            {
               judgment("A");
            }
            else
            {
               MapManager.changeMapWithCallback(1,function():void
               {
                  ModuleManager.showModule(ClientConfig.getAppModule("FortyNineWarPackagePlusMainPanel"),"正在打开....");
               });
            }
         },function():void
         {
            judgment("B");
         },function():void
         {
            judgment("C");
         },function():void
         {
            judgment("D");
         }],false);
      }
      
      private function judgment(param1:String) : void
      {
         var chooseAnswer:String = param1;
         if(chooseAnswer == this._rightAnswerArr[this._compeleteNum])
         {
            SocketConnection.addCmdListener(45641,function(param1:SocketEvent):void
            {
               SocketConnection.removeCmdListener(45641,arguments.callee);
               update();
            });
            SocketConnection.send(45641,3,0);
         }
         else
         {
            NpcDialog.show(NPC.CICI,["请你重新考虑好答案再回答吧！"],["确定。"],[function():void
            {
            }],false);
         }
      }
      
      public function update() : void
      {
         KTool.getMultiValue([3915],function(param1:Array):void
         {
            var va:Array = param1;
            _compeleteNum = va[0];
            conLevel["itemNumTx"].text = String(va[0]) + "/5";
            if(_fun != null)
            {
               _fun();
            }
            answerQuestion();
            if(va[0] >= 5)
            {
               NpcDialog.show(NPC.CICI,[_questionArr[5]],_answerArr[5],[function():void
               {
                  MapManager.changeMapWithCallback(1,function():void
                  {
                     ModuleManager.showModule(ClientConfig.getAppModule("FortyNineWarPackagePlusMainPanel"),"正在打开....");
                  });
               }],false);
            }
         });
      }
      
      override public function destroy() : void
      {
         LevelManager.iconLevel.visible = true;
         ToolBarController.panel.visible = true;
         conLevel.removeEventListener(MouseEvent.CLICK,this.onConLevel);
         super.destroy();
      }
   }
}

